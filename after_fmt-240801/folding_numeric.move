//# run
script {
    const SHL0: u8 = 1 << 7;
    const SHL1: u64 = 1 << 63;
    const SHL2: u128 = 1 << 127;
    const SHL3: u16 = 1 << 15;
    const SHL4: u32 = 1 << 31;
    const SHL5: u256 = 1 << 255;

    const SHR0: u8 = 128 >> 7;
    const SHR1: u64 = 18446744073709551615 >> 63;
    const SHR2: u128 = 340282366920938463463374607431768211455 >> 127;
    const SHR3: u16 = 36863 >> 15;
    const SHR4: u32 = 2415919103 >> 31;
    const SHR5: u256 =
        65133050195990359925758679067386948167464366374422817272194891004451135422463 >>
        255;

    const DIV0: u8 = 255 / 2;
    const DIV1: u64 = 18446744073709551615 / 2;
    const DIV2: u128 = 340282366920938463463374607431768211455 / 2;
    const DIV3: u16 = 65535 / 2;
    const DIV4: u32 = 4294967295 / 2;
    const DIV5: u256 =
        115792089237316195423570985008687907853269984665640564039457584007913129639935 / 2;

    const MOD0: u8 = 255 % 2;
    const MOD1: u64 = 18446744073709551615 % 2;
    const MOD2: u128 = 340282366920938463463374607431768211455 % 2;
    const MOD3: u16 = 65535 % 2;
    const MOD4: u32 = 4294967295 % 2;
    const MOD5: u256 =
        115792089237316195423570985008687907853269984665640564039457584007913129639935 % 2;

    const ADD0: u8 = 254 + 1;
    const ADD1: u64 = 18446744073709551614 + 1;
    const ADD2: u128 = 340282366920938463463374607431768211454 + 1;
    const ADD3: u16 = 65534 + 1;
    const ADD4: u32 = 4294967294 + 1;
    const ADD5: u256 =
        115792089237316195423570985008687907853269984665640564039457584007913129639934 + 1;

    const SUB0: u8 = 255 - 255;
    const SUB1: u64 = 18446744073709551615 - 18446744073709551615;
    const SUB2: u128 = 340282366920938463463374607431768211455
        - 340282366920938463463374607431768211455;
    const SUB3: u16 = 65535 - 65535;
    const SUB4: u32 = 4294967295 - 4294967295;
    const SUB5: u256 =
        115792089237316195423570985008687907853269984665640564039457584007913129639935 -
        115792089237316195423570985008687907853269984665640564039457584007913129639935;

    const CAST0: u8 = ((255: u64) as u8);
    const CAST1: u64 = ((18446744073709551615: u128) as u64);
    const CAST2: u128 = ((1: u8) as u128);
    const CAST3: u16 = ((65535: u64) as u16);
    const CAST4: u32 = ((4294967295: u128) as u32);
    const CAST5: u256 = ((1: u8) as u256);

    const BAND0: u8 = 255 & 255;
    const BAND1: u64 = 18446744073709551615 & 18446744073709551615;
    const BAND2: u256 = 340282366920938463463374607431768211455
        & 340282366920938463463374607431768211455;
    const BAND3: u16 = 65535 & 65535;
    const BAND4: u32 = 4294967295 & 4294967295;
    const BAND5: u256 =
        115792089237316195423570985008687907853269984665640564039457584007913129639935 &
        115792089237316195423570985008687907853269984665640564039457584007913129639935;

    const BOR0: u8 = 255 | 255;
    const BOR1: u64 = 18446744073709551615 | 18446744073709551615;
    const BOR2: u256 = 340282366920938463463374607431768211455
        | 340282366920938463463374607431768211455;
    const BOR3: u16 = 65535 | 65535;
    const BOR4: u32 = 4294967295 | 4294967295;
    const BOR5: u256 =
        115792089237316195423570985008687907853269984665640564039457584007913129639935 |
        115792089237316195423570985008687907853269984665640564039457584007913129639935;

    const BXOR0: u8 = 255 ^ 255;
    const BXOR1: u64 = 18446744073709551615 ^ 18446744073709551615;
    const BXOR2: u256 = 340282366920938463463374607431768211455
        ^ 340282366920938463463374607431768211455;
    const BXOR3: u16 = 65535 ^ 65535;
    const BXOR4: u32 = 4294967295 ^ 4294967295;
    const BXOR5: u256 =
        115792089237316195423570985008687907853269984665640564039457584007913129639935 ^
        115792089237316195423570985008687907853269984665640564039457584007913129639935;
    fun main() {
        assert!(SHL0 == 128, 42);
        assert!(SHL1 == 9223372036854775808, 42);
        assert!(SHL2 == 170141183460469231731687303715884105728, 42);
        assert!(SHL0 == 0x80, 42);
        assert!(SHL1 == 0x8000000000000000, 42);
        assert!(SHL2 == 0x80000000000000000000000000000000, 42);
        assert!(SHL3 == 32768, 42);
        assert!(SHL4 == 2147483648, 42);
        assert!(
            SHL5
                ==
                57896044618658097711785492504343953926634992332820282019728792003956564819968,
            42
        );
        assert!(SHL3 == 0x8000, 42);
        assert!(SHL4 == 0x80000000, 42);
        assert!(
            SHL5 == 0x8000000000000000000000000000000000000000000000000000000000000000, 42
        );

        assert!(SHR0 == 1, 42);
        assert!(SHR1 == 1, 42);
        assert!(SHR2 == 1, 42);
        assert!(SHR0 == 0x1, 42);
        assert!(SHR1 == 0x1, 42);
        assert!(SHR2 == 0x1, 42);
        assert!(SHR3 == 1, 42);
        assert!(SHR4 == 1, 42);
        assert!(SHR5 == 1, 42);
        assert!(SHR3 == 0x1, 42);
        assert!(SHR4 == 0x1, 42);
        assert!(SHR5 == 0x1, 42);

        assert!(DIV0 == 127, 42);
        assert!(DIV1 == 9223372036854775807, 42);
        assert!(DIV2 == 170141183460469231731687303715884105727, 42);
        assert!(DIV0 == 0x7F, 42);
        assert!(DIV1 == 0x7FFFFFFFFFFFFFFF, 42);
        assert!(DIV2 == 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 42);
        assert!(DIV3 == 32767, 42);
        assert!(DIV4 == 2147483647, 42);
        assert!(
            DIV5
                ==
                57896044618658097711785492504343953926634992332820282019728792003956564819967,
            42
        );
        assert!(DIV3 == 0x7FFF, 42);
        assert!(DIV4 == 0x7FFFFFFF, 42);
        assert!(
            DIV5 == 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 42
        );

        assert!(MOD0 == 1, 42);
        assert!(MOD1 == 1, 42);
        assert!(MOD2 == 1, 42);
        assert!(MOD0 == 0x1, 42);
        assert!(MOD1 == 0x1, 42);
        assert!(MOD2 == 0x1, 42);
        assert!(MOD3 == 1, 42);
        assert!(MOD4 == 1, 42);
        assert!(MOD5 == 1, 42);
        assert!(MOD3 == 0x1, 42);
        assert!(MOD4 == 0x1, 42);
        assert!(MOD5 == 0x1, 42);

        assert!(ADD0 == 255, 42);
        assert!(ADD1 == 18446744073709551615, 42);
        assert!(ADD2 == 340282366920938463463374607431768211455, 42);
        assert!(ADD0 == 0xFF, 42);
        assert!(ADD1 == 0xFFFFFFFFFFFFFFFF, 42);
        assert!(ADD2 == 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 42);
        assert!(ADD3 == 65535, 42);
        assert!(ADD4 == 4294967295, 42);
        assert!(
            ADD5
                ==
                115792089237316195423570985008687907853269984665640564039457584007913129639935,
            42
        );
        assert!(ADD3 == 0xFFFF, 42);
        assert!(ADD4 == 0xFFFFFFFF, 42);
        assert!(
            ADD5 == 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 42
        );

        assert!(SUB0 == 0, 42);
        assert!(SUB1 == 0, 42);
        assert!(SUB2 == 0, 42);
        assert!(SUB0 == 0x0, 42);
        assert!(SUB1 == 0x0, 42);
        assert!(SUB2 == 0x0, 42);
        assert!(SUB3 == 0, 42);
        assert!(SUB4 == 0, 42);
        assert!(SUB5 == 0, 42);
        assert!(SUB3 == 0x0, 42);
        assert!(SUB4 == 0x0, 42);
        assert!(SUB5 == 0x0, 42);

        assert!(CAST0 == 255, 42);
        assert!(CAST1 == 18446744073709551615, 42);
        assert!(CAST2 == 1, 42);
        assert!(CAST0 == 0xFF, 42);
        assert!(CAST1 == 0xFFFFFFFFFFFFFFFF, 42);
        assert!(CAST2 == 0x1, 42);
        assert!(CAST3 == 65535, 42);
        assert!(CAST4 == 4294967295, 42);
        assert!(CAST5 == 1, 42);
        assert!(CAST3 == 0xFFFF, 42);
        assert!(CAST4 == 0xFFFFFFFF, 42);
        assert!(CAST5 == 0x1, 42);

        assert!(BAND0 == 255, 42);
        assert!(BAND1 == 18446744073709551615, 42);
        assert!(BAND2 == 340282366920938463463374607431768211455, 42);
        assert!(BAND0 == 0xFF, 42);
        assert!(BAND1 == 0xFFFFFFFFFFFFFFFF, 42);
        assert!(BAND2 == 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 42);
        assert!(BAND3 == 65535, 42);
        assert!(BAND4 == 4294967295, 42);
        assert!(
            BAND5
                ==
                115792089237316195423570985008687907853269984665640564039457584007913129639935,
            42
        );
        assert!(BAND3 == 0xFFFF, 42);
        assert!(BAND4 == 0xFFFFFFFF, 42);
        assert!(
            BAND5 == 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF,
            42
        );

        assert!(BXOR0 == 0, 42);
        assert!(BXOR1 == 0, 42);
        assert!(BXOR2 == 0, 42);
        assert!(BXOR0 == 0x0, 42);
        assert!(BXOR1 == 0x0, 42);
        assert!(BXOR2 == 0x0, 42);
        assert!(BXOR3 == 0, 42);
        assert!(BXOR4 == 0, 42);
        assert!(BXOR5 == 0, 42);
        assert!(BXOR3 == 0x0, 42);
        assert!(BXOR4 == 0x0, 42);
        assert!(BXOR5 == 0x0, 42);
    }
}
