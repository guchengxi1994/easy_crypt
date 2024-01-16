use std::any::Any;

use super::Operate;

pub struct NotOperator {}

impl Operate for NotOperator {
    fn operate(&self, d: &[u8]) -> Vec<u8> {
        d.iter().map(|&x1| !x1).collect::<Vec<u8>>()
    }

    fn as_any(&self) -> &dyn Any {
        self
    }
}
