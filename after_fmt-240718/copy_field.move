module 0x8675309::M {
    struct S has copy, drop {
        f: u64,
        g: u64
    }

    fun id<T>(r: &T): &T {
        r
    }

    fun id_mut<T>(r: &mut T): &mut T {
        r
    }

    fun t0() {
        let s = S { f: 0, g: 0 };
        let f = &s.f;
        copy s;
        *f;
        s;

        let s = S { f: 0, g: 0 };
        let f = &mut s.f;
        *f;
        copy s;
        s;

        let s = S { f: 0, g: 0 };
        let f = id(&s.f);
        copy s;
        *f;
        s;

        let s = S { f: 0, g: 0 };
        let f = id_mut(&mut s.f);
        *f;
        copy s;
        s;
    }
}
