script {
    fun main() {
        let x: u64;
        if (false) x = 100;
        assert!(x == 100, 42);
    }
}

// check: COPYLOC_UNAVAILABLE_ERROR
