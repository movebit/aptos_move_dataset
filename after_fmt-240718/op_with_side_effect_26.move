//# publish
module 0xc0ffee::m {
    public fun test(): u64 {
        let x = 1;
        x
            + {
                x = { x + {
                    x = x + 1;
                    x
                } + {
                    x = x + 1;
                    x
                } };
                x
            } + {
            x = { x + {
                x = x + 1;
                x
            } + {
                x = x + 1;
                x
            } };
            x
        }
    }
}

//# run 0xc0ffee::m::test
