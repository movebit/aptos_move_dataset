module 0x8675309::M {
    struct Box<T> has drop {
        f: T
    }

    fun t0(r_imm: &u64, r_mut: &mut u64) {
        Box { f: r_imm };
        Box { f: r_mut };
    }
}
