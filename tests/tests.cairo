use core::result::ResultTrait;
use core::option::OptionTrait;
use core::traits::Into;
use raito::engine::target_to_bits;

#[test]
fn test_target_to_bits_zero() {
    let result = target_to_bits(0.into());
    assert!(result.is_err(), "Should error on zero input");
}

#[test]
fn test_target_to_bits_overflow() {
    let target: u256 = 0x01000000000000000000000000000000000000000000000000000000000000000;
    let result = target_to_bits(target);
    assert!(result.is_err(), "Should error on overflow");
}

#[test]
fn test_target_to_bits_medium_target() {
    let medium_target: u256 = 0x00000000000FFFFF000000000000000000000000000000000000000000000000;
    let result = target_to_bits(medium_target).unwrap();
    assert!(result == 454033407, "Incorrect bits for medium target");
}

#[test]
fn test_target_to_bits_normalization() {
    let target: u256 = 0x00000000007FFFFF800000000000000000000000000000000000000000000000;
    let result = target_to_bits(target).unwrap();
    assert!(result == 0x1b7fffff, "Incorrect bits after normalization");
}

#[test]
fn test_target_to_bits_max_target() {
    let max_target: u256 = 0x00000000FFFF0000000000000000000000000000000000000000000000000000;
    let result = target_to_bits(max_target).unwrap();
    assert!(result == 0x1d00ffff, "Incorrect bits for max target");
}