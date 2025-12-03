#[rustler::nif]
fn add(a: i64, b: i64) -> i64 {
    a + b
}

#[rustler::nif]
fn invalid_product(number: i64) -> bool {
    let s = number.to_string();
    let len = s.len();

    if !len.is_multiple_of(2) {
        return false;
    }

    let (first, second) = s.split_at(len / 2);

    first == second
}

#[rustler::nif]
fn has_repeating_pattern(number: i64) -> bool {
    if number < 11 {
        return false;
    }

    let s = number.to_string();
    let len = s.len();

    for pattern_len in 1..=len / 2 {
        if len.is_multiple_of(pattern_len) {
            let pattern = &s[..pattern_len];
            let mut all_match = true;

            for i in (0..len).step_by(pattern_len) {
                if &s[i..i + pattern_len] != pattern {
                    all_match = false;
                    break;
                }
            }

            if all_match {
                return true;
            }
        }
    }

    false
}

rustler::init!("Elixir.Aoc2025");
