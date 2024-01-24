use std::any::Any;

use super::Operate;

pub struct XOROperator {
    pub key: Vec<u8>,
}

impl Operate for XOROperator {
    fn operate(&self, mut d: &[u8]) -> Vec<u8> {
        let mut buffer = vec![0; self.key.len()];

        let mut result: Vec<u8> = Vec::new();

        while let Ok(n) = std::io::Read::read(&mut d, &mut buffer) {
            if n == 0 {
                break;
            }
            let r = buffer[..n]
                .iter()
                .zip(self.key.iter())
                .map(|(&x1, &x2)| x1 ^ x2)
                .collect::<Vec<u8>>();
            result.extend(r);
        }
        result
    }

    fn as_any(&self) -> &dyn Any {
        self
    }
}
