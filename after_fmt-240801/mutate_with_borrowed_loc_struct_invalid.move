module 0x8675309::M {
    struct X has key {
        b: bool
    }

    struct S has copy, drop {
        z: u64
    }

    fun t1() {
        let x = X { b: true };
        let y = &x;
        x = X { b: true };
        move y;
        X { b: _ } = x;
    }

    fun t2() {
        let s = S { z: 2 };
        let y = &s;
        let z = &y.z;
        s = S { z: 7 };
        z;
        s;
    }
}

// check: STLOC_UNSAFE_TO_DESTROY_ERROR
// check: STLOC_UNSAFE_TO_DESTROY_ERROR
