//# run
script {
    fun main() {
        assert!(0u256 + 0u256 == 0u256, 1000);
        assert!(0u256 + 1u256 == 1u256, 1001);
        assert!(1u256 + 1u256 == 2u256, 1002);

        assert!(13u256 + 67u256 == 80u256, 1100);
        assert!(100u256 + 10u256 == 110u256, 1101);

        assert!(
            0u256
                +
                115792089237316195423570985008687907853269984665640564039457584007913129639935u256 ==

            115792089237316195423570985008687907853269984665640564039457584007913129639935u256,
            1200,
        );
        assert!(
            1u256
                +
                115792089237316195423570985008687907853269984665640564039457584007913129639934u256 ==

            115792089237316195423570985008687907853269984665640564039457584007913129639935u256,
            1201,
        );
        assert!(
            5u256
                +
                115792089237316195423570985008687907853269984665640564039457584007913129639930u256 ==

            115792089237316195423570985008687907853269984665640564039457584007913129639935u256,
            1202,
        );
    }
}

//# run
script {
    fun main() {
            // should fail
            1u256
            +
                115792089237316195423570985008687907853269984665640564039457584007913129639935u256;
    }
}

//# run
script {
    fun main() {
        // should fail
        105792089237316195423570985008687907853269984665640564039457584007913129639935u256
            +
            105792089237316195423570985008687907853269984665640564039457584007913129639935;
    }
}

//# run
script {
    fun main() {
        assert!(0u256 - 0u256 == 0u256, 2000);
        assert!(1u256 - 0u256 == 1u256, 2001);
        assert!(1u256 - 1u256 == 0u256, 2002);

        assert!(52u256 - 13u256 == 39u256, 2100);
        assert!(100u256 - 10u256 == 90u256, 2101);

        assert!(


            115792089237316195423570985008687907853269984665640564039457584007913129639935u256
            -
            115792089237316195423570985008687907853269984665640564039457584007913129639935u256 ==
             0u256,
            2200,
        );
        assert!(5u256 - 1u256 - 4u256 == 0u256, 2201);
    }
}

//# run
script {
    fun main() {
        // should fail
        0u256 - 1u256;
    }
}

//# run
script {
    fun main() {
        // should fail
        54u256 - 100u256;
    }
}

//# run
script {
    fun main() {
        assert!(0u256 * 0u256 == 0u256, 3000);
        assert!(1u256 * 0u256 == 0u256, 3001);
        assert!(1u256 * 1u256 == 1u256, 3002);

        assert!(6u256 * 7u256 == 42u256, 3100);
        assert!(10u256 * 10u256 == 100u256, 3101);

        assert!(


            57896044618658097711785492504343953926634992332820282019728792003956564819967u256
            * 2u256
                ==
                115792089237316195423570985008687907853269984665640564039457584007913129639934u256,
            3200,
        );
    }
}

//# run
script {
    fun main() {
            // should fail
            578960446186580977117853953926634992332820282019728792003956564819967u256
            * 57896044618343953926634992332820282019728792003956564819967u256;
    }
}

//# run
script {
    fun main() {
        // should fail
        37896044618658097711785492504343953926634992332820282019728792003956564819967u256
            * 2u256;
    }
}

//# run
script {
    fun main() {
        assert!(0u256 / 1u256 == 0u256, 4000);
        assert!(1u256 / 1u256 == 1u256, 4001);
        assert!(1u256 / 2u256 == 0u256, 4002);

        assert!(6u256 / 3u256 == 2u256, 4100);
        assert!(


            115792089237316195423570985008687907853269984665640564039457584007913129639935u256
            / 1234567891234512345678912345u256
                == 93791593041942242554519147120179023890934338607714u256,
            4101,
        );

        assert!(


            115792089237316195423570985008687907853269984665640564039457584007913129639934u256
            /
            115792089237316195423570985008687907853269984665640564039457584007913129639935u256 ==
             0u256,
            4200,
        );
        assert!(


            115792089237316195423570985008687907853269984665640564039457584007913129639935u256
            /
            115792089237316195423570985008687907853269984665640564039457584007913129639934u256 ==
             1u256,
            4201,
        );
    }
}

//# run
script {
    fun main() {
        // should fail
        0u256 / 0u256;
    }
}
// check: ARITHMETIC_ERROR

//# run
script {
    fun main() {
        1u256 / 0u256;
    }
}

//# run
script {
    fun main() {
        // should fail
        115792089237316195423570985008687907853269984665640564039457584007913129639935u256
            / 0u256;
    }
}

//# run
script {
    fun main() {
        assert!(0u256 % 1u256 == 0u256, 5000);
        assert!(1u256 % 1u256 == 0u256, 5001);
        assert!(1u256 % 2u256 == 1u256, 5002);

        assert!(8u256 % 3u256 == 2u256, 5100);
        assert!(


            115792089237316195423570985008687907853269984665640564039457584007913129639935u256
            % 1234567891234512345678912345u256 == 440810759282713395982810605u256,
            5101,
        );

        assert!(


            115792089237316195423570985008687907853269984665640564039457584007913129639934u256
            %
            115792089237316195423570985008687907853269984665640564039457584007913129639935u256 ==

            115792089237316195423570985008687907853269984665640564039457584007913129639934u256,
            5200,
        );
        assert!(


            115792089237316195423570985008687907853269984665640564039457584007913129639934u256
            %
            115792089237316195423570985008687907853269984665640564039457584007913129639934u256 ==
             0u256,
            5201,
        );
    }
}

//# run
script {
    fun main() {
        // should fail
        0u256 % 0u256;
    }
}

//# run
script {
    fun main() {
        // should fail
        1u256 % 0u256;
    }
}

//# run
script {
    fun main() {
        // should fail
        4294967294u256 % 0u256;
    }
}
