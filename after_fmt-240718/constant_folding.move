//# publish
module 0xcafe::MyModule {
    fun main() {
        use std::vector;

        let xbool = vector[
            // 7 true
            0 == 0, 0 == 0, 0 == 0, false == false, 0x42 == 0x42, x"42" == x"42", b"hello" ==
             b"hello",
            // 7 false
            0 == 1, 0 == 1, 0 == 1, false == true, 0x42 == 0x43, x"42" == x"0422", b"hello" ==
             b"XhelloX",
            // 7 true
            0 != 1, 0 != 1, 0 != 1, false != true, 0x42 != 0x43, x"42" != x"0422", b"hello"
            != b"XhelloX",
            // 7 false
            0 != 0, 0 != 0, 0 != 0, false != false, 0x42 != 0x42, x"42" != x"42", b"hello"
            != b"hello",
            // 1 false
            ((0 == 0) == (b"hello" != b"bye")) == false,
            // 1 true
            true && true,
            // 3 false
            true && false, false && true, false && false,
            // 3 true
            true || true, true || false, false || true,
            // false
            false || false,
            // true
            true,
            // false
            false,
            // ?
            !((true
                    && false)
                || (false
                    || true)
                && true) || true];
        let xbool2 = vector[
            true, true, true, true, true, true, true, // 7 true
            false, false, false, false, false, false, false, // 7 false
            true, true, true, true, true, true, true, // 7 true
            false, false, false, false, false, false, false, // 7 false
            false, // 1 false
            true, // 2 true
            false, false, false, // 3 false
            true, true, true, // 3 true
            false, // false
            true, // true
            false, // false
            true];
        assert!(
            vector::length(&xbool) == vector::length(&xbool2),
            vector::length(&xbool) - vector::length(&xbool),
        );
        assert!(
            vector::length(&xbool) == vector::length(&xbool2),
            vector::length(&xbool2) - vector::length(&xbool),
        );
        for (i in 0..vector::length(&xbool)) {
            assert!(vector::borrow(&xbool, i) == vector::borrow(&xbool2, i), i);
        };
        assert!(xbool == xbool2, 2);

        let xnum = vector<u256>[
            1 << 7, 1 << 63, ((1: u128) << 127 as u256), 128 >> 7, 18446744073709551615
                >> 63, ((340282366920938463463374607431768211455: u128) >> 127 as u256),
            255 / 2, 18446744073709551615 / 2, (
                (340282366920938463463374607431768211455: u128) / 2 as u256
            ), 255 % 2, 18446744073709551615 % 2, (
                (340282366920938463463374607431768211455: u128) % 2 as u256
            ), 254 + 1, 18446744073709551614 + 1, (
                (340282366920938463463374607431768211454: u128) + 1 as u256
            ), 255 - 255, 18446744073709551615 - 18446744073709551615, (
                (340282366920938463463374607431768211455: u128)
                    - (340282366920938463463374607431768211455: u128) as u256
            ), (((255: u64) as u8) as u256), (
                ((18446744073709551615: u128) as u64) as u256
            ), (((1: u8) as u128) as u256), 255& 255, 18446744073709551615
                & 18446744073709551615, (
                (340282366920938463463374607431768211455: u128)
                    & (340282366920938463463374607431768211455: u128) as u256
            ), 255 | 255, 18446744073709551615 | 18446744073709551615, (
                (340282366920938463463374607431768211455: u128)
                    |(340282366920938463463374607431768211455: u128) as u256
            ), 255 ^ 255, 18446744073709551615 ^ 18446744073709551615, (
                (340282366920938463463374607431768211455: u128)
                    ^(340282366920938463463374607431768211455: u128) as u256
            ), (((3402823669209384: u256) as u128) as u256), (
                (340282366920938463463374607431768211455340282366920938463463374607: u256)
                - 34 as u256
            ), (
                (340282366920938463463374607431768211455340282366920938463463374607: u256)
                - (340282366920938463463374607431768211455340: u256) as u256
            ), (
                (340282366920938463463374607431768211455340282366920938463463374607: u256) ^(
                    340282366920938463463374607431768211455340: u256
                ) as u256
            ), (
                (340282366920938463463374607431768211455340282366920938463463374607: u256) ^(
                    340282366920938463463374607431768211455: u256
                ) as u256
            ), 0];
        let xnum2 = vector<u256>[
            128, // 1 << 7
            9223372036854775808, // 1 << 63,
            170141183460469231731687303715884105728, // ((1: u128) << 127 as u256),
            1, // 128 >> 7,
            1, // 18446744073709551615 >> 63,
            1, // ((340282366920938463463374607431768211455: u128) >> 127 as u256),
            127, // 255 / 2,
            9223372036854775807, // 18446744073709551615 / 2,
            170141183460469231731687303715884105727, // ((340282366920938463463374607431768211455: u128) / 2 as u256),
            1, // 255 % 2
            1, // 18446744073709551615 % 2,
            1, // ((340282366920938463463374607431768211455: u128) % 2 as u256),
            255, // 254 + 1,
            18446744073709551615, // 18446744073709551614 + 1,
            340282366920938463463374607431768211455, // ((340282366920938463463374607431768211454: u128) + 1 as u256),
            0, // 255 - 255,
            0, // 18446744073709551615 - 18446744073709551615,
            0, // ((340282366920938463463374607431768211455: u128) - (340282366920938463463374607431768211455: u128) as u256),
            255, // (((255: u64) as u8) as u256),
            18446744073709551615, //(((18446744073709551615: u128) as u64) as u256),
            1, // (((1: u8) as u128) as u256),
            255, // 255 & 255,
            18446744073709551615, // 18446744073709551615 & 18446744073709551615,
            340282366920938463463374607431768211455, // ((340282366920938463463374607431768211455: u128) & (340282366920938463463374607431768211455: u128) as u256),
            255, // 255 | 255,
            18446744073709551615, // 18446744073709551615 | 18446744073709551615,
            340282366920938463463374607431768211455, // ((340282366920938463463374607431768211455: u128) | (340282366920938463463374607431768211455: u128) as u256),
            0, // 255 ^ 255,
            0, // ((340282366920938463463374607431768211455: u128) ^ (340282366920938463463374607431768211455: u128) as u256),
            0, // (((3402823669209384: u256) as u128) as u256),
            3402823669209384, // (((3402823669209384: u256) as u128) as u256),
            340282366920938463463374607431768211455340282366920938463463374573, // ((340282366920938463463374607431768211455340282366920938463463374607: u256) - 34 as u256),
            340282366920938463463374267149401290516876818992313506695251919267, // ((340282366920938463463374607431768211455340282366920938463463374607: u256) - (340282366920938463463374607431768211455340: u256) as u256),
            340282366920938463463374267149401290518196254258471629768325169763, // ((340282366920938463463374607431768211455340282366920938463463374607: u256) ^ (340282366920938463463374607431768211455340: u256) as u256),
            340282366920938463463374607091485844535721254169704454104768413936, // ((340282366920938463463374607431768211455340282366920938463463374607: u256) ^ (340282366920938463463374607431768211455: u256) as u256),
            0 // 0
        ];

        let len1 = vector::length(&xnum);
        let len2 = vector::length(&xnum2);
        let delta;
        if (len1 < len2) {
            delta = 1000 + len2 - len1;
        } else {
            delta = 2000 + len1 - len2;
        };
        assert!(delta == 2000, delta);
        for (i in 0..vector::length(&xnum)) {
            assert!(vector::borrow(&xnum, i) == vector::borrow(&xnum2, i), i);
        };
        assert!(xnum == xnum2, 3000 + 2);

        let y = {
            ();
            ();
            (true
                    && true)
                && (!false)
                && (1 << 7 == 128)
                && (128 >> 7 == 1)
                && (255 / 2 == 127)
                && (255 % 2 == 1)
                && (254 + 1 == 255)
                && (255 - 255 == 0)
                && (255& 255 == 255)
                && (255 | 255 == 255)
                && (255 ^ 255 == 0)
                && (x"42" == x"42")
                && (b"hello" != b"bye")
        };
        assert!(y, 4000 + 42);
    }
}

//# run 0xcafe::MyModule::main
