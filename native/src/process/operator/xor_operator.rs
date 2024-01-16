use std::any::Any;

use super::Operate;

pub struct XOROperator {
    pub key: Vec<u8>,
}

impl Operate for XOROperator {
    fn operate(&self, d: &[u8]) -> Vec<u8> {
        d.iter()
            .zip(self.key.iter())
            .map(|(&x1, &x2)| x1 ^ x2)
            .collect::<Vec<u8>>()
    }

    fn as_any(&self) -> &dyn Any {
        self
    }
}
