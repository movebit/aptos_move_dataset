//# run
// Number of bits shifted >= total number of bits in the number.
script {
    fun main() {
        // should fail
        0u8 << 8u8;
    }
}

//# run
script {
    fun main() {
        // should fail
        0u64 << 64u8;
    }
}

//# run
script {
    fun main() {
        // should fail
        0u128 << 128u8;
    }
}

//# run
script {
    fun main() {
        // should fail
        0u8 >> 8u8;
    }
}

//# run
script {
    fun main() {
        // should fail
        0u64 >> 64u8;
    }
}

//# run
script {
    fun main() {
        // should fail
        0u128 >> 128u8;
    }
}

//# run
script {
    fun main() {
        // should fail
        0u16 << 16u8;
    }
}

//# run
script {
    fun main() {
        // should fail
        0u32 << 32u8;
    }
}

//# run
script {
    fun main() {
        // should fail
        0u16 >> 16u8;
    }
}

//# run
script {
    fun main() {
        // should fail
        0u32 >> 32u8;
    }
}

// Shifting 0 results in 0.
//# run
script {
    fun main() {
        assert!(0u8 << 4u8 == 0u8, 1000);
        assert!(0u64 << 1u8 == 0u64, 1001);
        assert!(0u128 << 127u8 == 0u128, 1002);
        assert!(0u16 << 15u8 == 0u16, 1003);
        assert!(0u32 << 4u8 == 0u32, 1004);
        assert!(0u256 << 255u8 == 0u256, 1005);

        assert!(0u8 >> 4u8 == 0u8, 1100);
        assert!(0u64 >> 1u8 == 0u64, 1101);
        assert!(0u128 >> 127u8 == 0u128, 1102);
        assert!(0u16 >> 15u8 == 0u16, 1103);
        assert!(0u32 >> 31u8 == 0u32, 1104);
        assert!(0u256 >> 255u8 == 0u256, 1105);
    }
}

// Shifting by 0 bits results in the same number.
//# run
script {
    fun main() {
        assert!(100u8 << 0u8 == 100u8, 2000);
        assert!(43u64 << 0u8 == 43u64, 2001);
        assert!(
            57348765484584586725315342563424u128 << 0u8
                == 57348765484584586725315342563424u128,
            2002,
        );
        assert!(1000u16 << 0u8 == 1000u16, 2003);
        assert!(10000u32 << 0u8 == 10000u32, 2004);
        assert!(

            115792089237316195423570985008687907853269984665640564039457584007913129639935u256
            << 0u8
                ==
                115792089237316195423570985008687907853269984665640564039457584007913129639935u256,
            2005,
        );

        assert!(100u8 >> 0u8 == 100u8, 2100);
        assert!(43u64 >> 0u8 == 43u64, 2101);
        assert!(1000u16 >> 0u8 == 1000u16, 2103);
        assert!(10000u32 >> 0u8 == 10000u32, 2104);
        assert!(

            115792089237316195423570985008687907853269984665640564039457584007913129639935u256
            >> 0u8
                ==
                115792089237316195423570985008687907853269984665640564039457584007913129639935u256,
            2105,
        );
    }
}

// shl/shr by 1 equivalent to mul/div by 2.
//# run
script {
    fun main() {
        assert!(1u8 << 1u8 == 2u8, 3000);
        assert!(7u64 << 1u8 == 14u64, 3001);
        assert!(1000u128 << 1u8 == 2000u128, 3002);
        assert!(3u16 << 1u8 == 6u16, 3003);
        assert!(7u32 << 1u8 == 14u32, 3004);
        assert!(1000u256 << 1u8 == 2000u256, 3005);

        assert!(1u8 >> 1u8 == 0u8, 3100);
        assert!(7u64 >> 1u8 == 3u64, 3101);
        assert!(1000u128 >> 1u8 == 500u128, 3102);
        assert!(3u16 >> 1u8 == 1u16, 3103);
        assert!(7u32 >> 1u8 == 3u32, 3104);
        assert!(1000u256 >> 1u8 == 500u256, 3105);
    }
}

// Underflowing results in 0.
//# run
script {
    fun main() {
        assert!(1234u64 >> 63u8 == 0u64, 4000);
        assert!(3u8 >> 5u8 == 0u8, 4001);
        assert!(43152365326753472145312542634526753u128 >> 127u8 == 0u128, 4002);
        assert!(1234u16 >> 15u8 == 0u16, 4003);
        assert!(123456u32 >> 31u8 == 0u32, 4004);
        assert!(

            11579208923731619542357098500868790785326998466564056403945758400791312963993u256
            >> 255u8 == 0u256,
            4005,
        );
    }
}

// Overflowing results are truncated.
//# run
script {
    fun main() {
        assert!(7u8 << 7u8 == 128u8, 5000);
        assert!(7u64 << 62u8 == 13835058055282163712u64, 5001);
        assert!(2u128 << 127u8 == 0u128, 5002);
        assert!(7u16 << 15u8 == 32768u16, 5003);
        assert!(17u32 << 30u8 == 1073741824u32, 5004);
        assert!(
            7u256 << 254u8
                ==
                86844066927987146567678238756515930889952488499230423029593188005934847229952u256,
            5005,
        );
    }
}

// Some random tests.
//# run
script {
    fun main() {
        assert!(54u8 << 3u8 == 176u8, 6000);
        assert!(5u8 << 2u8 == 20u8, 6001);
        assert!(124u8 << 5u8 == 128u8, 6002);

        assert!(326348456u64 << 13u8 == 2673446551552u64, 6100);
        assert!(218u64 << 30u8 == 234075717632u64, 6101);
        assert!(345325745376476456u64 << 47u8 == 2203386117691015168u64, 6102);

        assert!(95712896789423756892376u128 << 4u8 == 1531406348630780110278016u128, 6200);
        assert!(
            8629035907847368941279654523567912314u128 << 77u8
                == 317056859699765342273530379836650946560u128,
            6201,
        );
        assert!(
            5742389768935678297185789157531u128 << 10u8
                == 5880207123390134576318248097311744u128,
            6202,
        );
        assert!(
            295429678238907658936718926478967892769u128 << 83u8
                == 78660438169199498567214234129963941888u128,
            6203,
        );

        assert!(12u16 << 4u8 == 192u16, 6300);
        assert!(1234u16 << 12u8 == 8192u16, 6301);
        assert!(6553u16 << 15u8 == 32768u16, 6302);

        assert!(1234567u32 << 12u8 == 761819136u32, 6400);
        assert!(1234567u32 << 17u8 == 2903375872u32, 6401);
        assert!(12345671u32 << 27u8 == 939524096u32, 6402);

        assert!(123u256 << 1u8 == 246u256, 6500);
        assert!(123453u256 << 13u8 == 1011326976u256, 6501);
        assert!(123453678909u256 << 76u8 == 9327896247469005265829994770202624u256, 6502);
        assert!(
            1234536789093546757803u256 << 168u8
                ==
                461895049882996264654333091841553462264195467433049741837793730775482368u256,
            6503,
        );
        assert!(
            1234536789093546757803786604381691994985672142341299639418u256 << 202u8
                ==
                33658913632735705985908889087832028406806276615240336691180752852867975479296u256,
            6504,
        );
    }
}
