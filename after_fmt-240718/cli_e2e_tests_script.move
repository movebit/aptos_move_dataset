script {
    use aptos_framework::aptos_coin;
    use aptos_framework::coin;

    fun main(
        first: &signer,
        second: &signer,
        amount_first: u64,
        amount_second: u64,
        dst_first: address,
        dst_second: address,
        deposit_first: u64
    ) {
        let coin_first = coin::withdraw<aptos_coin::AptosCoin>(first, amount_first);
        let coin_second = coin::withdraw<aptos_coin::AptosCoin>(second, amount_second);

        coin::merge(&mut coin_first, coin_second);

        let coin_second =
            coin::extract(
                &mut coin_first,
                amount_first + amount_second - deposit_first
            );

        coin::deposit(dst_first, coin_first);
        coin::deposit(dst_second, coin_second);
    }
}
