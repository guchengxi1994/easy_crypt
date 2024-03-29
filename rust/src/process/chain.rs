use super::operator::{
    aes_operator::{AesDecryptOperator, AesOperator},
    not_operator::NotOperator,
    xor_operator::XOROperator,
    Operate,
};

/**
    encrypt chain for customized encryption algorithm
*/
pub struct Chain {
    encryptor: Vec<Box<dyn Operate>>,
    decryptor: Vec<Box<dyn Operate>>,
    input: Vec<u8>,
}

impl Chain {
    pub fn default() -> Self {
        Self {
            encryptor: Vec::new(),
            decryptor: Vec::new(),
            input: "I love China".as_bytes().to_vec(),
        }
    }

    fn set_encryptor(&mut self, v: Vec<Box<dyn Operate>>) {
        for en in &v {
            if let Some(_xor) = en.as_any().downcast_ref::<XOROperator>() {
                self.decryptor.insert(
                    0,
                    Box::new(XOROperator {
                        key: _xor.key.clone(),
                    }),
                );
            } else if let Some(_aes) = en.as_any().downcast_ref::<AesOperator>() {
                self.decryptor.insert(
                    0,
                    Box::new(AesDecryptOperator {
                        key: _aes.key.clone(),
                        nonce: _aes.nonce.clone(),
                    }),
                );
            } else {
                self.decryptor.insert(0, Box::new(NotOperator {}));
            }
        }
        self.encryptor = v;
    }

    pub fn add_encrypt_operator(&mut self, v: Box<dyn Operate>) {
        if let Some(_xor) = v.as_any().downcast_ref::<XOROperator>() {
            self.decryptor.insert(
                0,
                Box::new(XOROperator {
                    key: _xor.key.clone(),
                }),
            );
        } else if let Some(_aes) = v.as_any().downcast_ref::<AesOperator>() {
            self.decryptor.insert(
                0,
                Box::new(AesDecryptOperator {
                    key: _aes.key.clone(),
                    nonce: _aes.nonce.clone(),
                }),
            );
        } else {
            self.decryptor.insert(0, Box::new(NotOperator {}));
        }
        self.encryptor.push(v);
    }

    pub fn encrypt(&mut self) -> Vec<u8> {
        if self.encryptor.is_empty() {
            return self.input.clone();
        }

        let mut result = self.input.clone();

        for en in &self.encryptor {
            result = en.operate(&result).to_vec();
        }
        result
    }

    pub fn decrypt(&mut self) -> Vec<u8> {
        let mut result = self.encrypt();
        for en in &self.decryptor {
            result = en.operate(&result).to_vec();
        }
        result
    }

    pub fn check(&mut self) -> bool {
        let mut result = self.encrypt();
        for en in &self.decryptor {
            result = en.operate(&result).to_vec();
        }
        result == self.input
    }
}

pub fn get_results(operators: Vec<String>) -> Vec<String> {
    let mut a = "I love China".as_bytes().to_vec();
    let mut results: Vec<String> = Vec::new();
    for i in operators {
        match i.to_lowercase().as_str() {
            "xor" => {
                let en = XOROperator {
                    key: "qwerty".as_bytes().to_vec(),
                };
                a = en.operate(&a);
                results.push(String::from_utf8_lossy(&a).to_string());
            }
            "aes" => {
                let en = AesOperator::default();
                a = en.operate(&a);
                results.push(String::from_utf8_lossy(&a).to_string());
            }
            "not" => {
                let en = NotOperator {};
                a = en.operate(&a);
                results.push(String::from_utf8_lossy(&a).to_string());
            }
            _ => {}
        }
    }

    results
}
