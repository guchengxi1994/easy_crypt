pub mod aes_operator;
pub mod not_operator;
pub mod xor_operator;

use std::any::Any;

pub trait Operate {
    fn operate(&self, d: &[u8]) -> Vec<u8>;

    fn as_any(&self) -> &dyn Any;
}
