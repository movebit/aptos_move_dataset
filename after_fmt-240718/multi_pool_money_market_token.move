address 0x2 {
module Map {
    native struct T<K, V> has copy, drop, store;

    native public fun empty<K, V>(): T<K, V>;

    native public fun get<K, V>(m: &T<K, V>, k: &K): &V;
    native public fun get_mut<K, V>(m: &mut T<K, V>, k: &K): &mut V;

    native public fun contains_key<K, V>(m: &T<K, V>, k: &K): bool;
    // throws on duplicate as I don't feel like mocking up Option
    native public fun insert<K, V>(m: &T<K, V>, k: K, v: V);
    // throws on miss as I don't feel like mocking up Option
    native public fun remove<K, V>(m: &T<K, V>, k: &K): V;
}
}

address 0x2 {
module Token {

    struct Coin<AssetType: copy + drop> has store {
        type: AssetType,
        value: u64,
    }

    // control the minting/creation in the defining module of `ATy`
    public fun create<ATy: copy + drop>(type: ATy, value: u64): Coin<ATy> {
        Coin { type, value }
    }

    public fun value<ATy: copy + drop>(coin: &Coin<ATy>): u64 {
        coin.value
    }

    public fun split<ATy: copy + drop>(coin: Coin<ATy>, amount: u64): (Coin<ATy>, Coin<ATy>) {
        let other = withdraw(&mut coin, amount);
        (coin, other)
    }

    public fun withdraw<ATy: copy + drop>(coin: &mut Coin<ATy>, amount: u64): Coin<ATy> {
        assert!(coin.value >= amount, 10);
        coin.value = coin.value - amount;
        Coin { type: *&coin.type, value: amount }
    }

    public fun join<ATy: copy + drop>(xus: Coin<ATy>, coin2: Coin<ATy>): Coin<ATy> {
        deposit(&mut xus, coin2);
        xus
    }

    public fun deposit<ATy: copy + drop>(
        coin: &mut Coin<ATy>, check: Coin<ATy>
    ) {
        let Coin { value, type } = check;
        assert!(&coin.type == &type, 42);
        coin.value = coin.value + value;
    }

    public fun destroy_zero<ATy: copy + drop>(coin: Coin<ATy>) {
        let Coin { value, type: _ } = coin;
        assert!(value == 0, 11)
    }
}
}

address 0x3 {
module OneToOneMarket {
    use std::signer;
    use 0x2::Map;
    use 0x2::Token;

    struct Pool<AssetType: copy + drop> has key {
        coin: Token::Coin<AssetType>,
    }

    struct DepositRecord<phantom InputAsset: copy + drop, phantom OutputAsset: copy + drop> has key {
        // pool owner => amount
        record: Map::T<address, u64>
    }

    struct BorrowRecord<phantom InputAsset: copy + drop, phantom OutputAsset: copy + drop> has key {
        // pool owner => amount
        record: Map::T<address, u64>
    }

    struct Price<phantom InputAsset: copy + drop, phantom OutputAsset: copy + drop> has key {
        price: u64,
    }

    fun accept<AssetType: copy + drop + store>(
        account: &signer, init: Token::Coin<AssetType>
    ) {
        let sender = signer::address_of(account);
        assert!(!exists<Pool<AssetType>>(sender), 42);
        move_to(account, Pool<AssetType> { coin: init })
    }

    public fun register_price<In: copy + drop + store, Out: copy + drop + store>(
        account: &signer,
        initial_in: Token::Coin<In>,
        initial_out: Token::Coin<Out>,
        price: u64
    ) {
        accept<In>(account, initial_in);
        accept<Out>(account, initial_out);
        move_to(account, Price<In, Out> { price })
    }

    public fun deposit<In: copy + drop + store, Out: copy + drop + store>(
        account: &signer, pool_owner: address, coin: Token::Coin<In>
    ) acquires Pool, DepositRecord {
        let amount = Token::value(&coin);

        update_deposit_record<In, Out>(account, pool_owner, amount);

        let pool = borrow_global_mut<Pool<In>>(pool_owner);
        Token::deposit(&mut pool.coin, coin)
    }

    public fun borrow<In: copy + drop + store, Out: copy + drop + store>(
        account: &signer,
        pool_owner: address,
        amount: u64,
    ): Token::Coin<Out> acquires Price, Pool, DepositRecord, BorrowRecord {
        assert!(amount <= max_borrow_amount<In, Out>(account, pool_owner), 1025);

        update_borrow_record<In, Out>(account, pool_owner, amount);

        let pool = borrow_global_mut<Pool<Out>>(pool_owner);
        Token::withdraw(&mut pool.coin, amount)
    }

    fun max_borrow_amount<In: copy + drop + store, Out: copy + drop + store>(
        account: &signer, pool_owner: address
    ): u64 acquires Price, Pool, DepositRecord, BorrowRecord {
        let input_deposited = deposited_amount<In, Out>(account, pool_owner);
        let output_deposited = borrowed_amount<In, Out>(account, pool_owner);

        let input_into_output =
            input_deposited * borrow_global<Price<In, Out>>(pool_owner).price;
        let max_output =
            if (input_into_output < output_deposited) 0
            else (input_into_output - output_deposited);
        let available_output = {
            let pool = borrow_global<Pool<Out>>(pool_owner);
            Token::value(&pool.coin)
        };
        if (max_output < available_output) max_output else available_output

    }

    fun update_deposit_record<In: copy + drop + store, Out: copy + drop + store>(
        account: &signer, pool_owner: address, amount: u64
    ) acquires DepositRecord {
        let sender = signer::address_of(account);
        if (!exists<DepositRecord<In, Out>>(sender)) {
            move_to(account, DepositRecord<In, Out> { record: Map::empty() })
        };
        let record = &mut borrow_global_mut<DepositRecord<In, Out>>(sender).record;
        if (Map::contains_key(record, &pool_owner)) {
            let old_amount = Map::remove(record, &pool_owner);
            amount = amount + old_amount;
        };
        Map::insert(record, pool_owner, amount)
    }

    fun update_borrow_record<In: copy + drop + store, Out: copy + drop + store>(
        account: &signer, pool_owner: address, amount: u64
    ) acquires BorrowRecord {
        let sender = signer::address_of(account);
        if (!exists<BorrowRecord<In, Out>>(sender)) {
            move_to(account, BorrowRecord<In, Out> { record: Map::empty() })
        };
        let record = &mut borrow_global_mut<BorrowRecord<In, Out>>(sender).record;
        if (Map::contains_key(record, &pool_owner)) {
            let old_amount = Map::remove(record, &pool_owner);
            amount = amount + old_amount;
        };
        Map::insert(record, pool_owner, amount)
    }

    fun deposited_amount<In: copy + drop + store, Out: copy + drop + store>(
        account: &signer, pool_owner: address
    ): u64 acquires DepositRecord {
        let sender = signer::address_of(account);
        if (!exists<DepositRecord<In, Out>>(sender)) return 0;

        let record = &borrow_global<DepositRecord<In, Out>>(sender).record;
        if (Map::contains_key(record, &pool_owner)) *Map::get(record, &pool_owner) else 0
    }

    fun borrowed_amount<In: copy + drop + store, Out: copy + drop + store>(
        account: &signer, pool_owner: address
    ): u64 acquires BorrowRecord {
        let sender = signer::address_of(account);
        if (!exists<BorrowRecord<In, Out>>(sender)) return 0;

        let record = &borrow_global<BorrowRecord<In, Out>>(sender).record;
        if (Map::contains_key(record, &pool_owner)) *Map::get(record, &pool_owner) else 0
    }
}
}

address 0x70DD {
module ToddNickels {
    use 0x2::Token;
    use std::signer;

    struct T has copy, drop, store {}

    struct Wallet has key {
        nickels: Token::Coin<T>,
    }

    public fun init(account: &signer) {
        assert!(signer::address_of(account) == @0x70DD, 42);
        move_to(account, Wallet { nickels: Token::create(T {}, 0) })
    }

    public fun mint(account: &signer): Token::Coin<T> {
        assert!(signer::address_of(account) == @0x70DD, 42);
        Token::create(T {}, 5)
    }

    public fun destroy(c: Token::Coin<T>) acquires Wallet {
        Token::deposit(&mut borrow_global_mut<Wallet>(@0x70DD).nickels, c)
    }
}
}
