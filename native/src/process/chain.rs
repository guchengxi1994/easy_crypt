use std::any::Any;

pub trait Operate {
    fn operate(&self, d: &[u8]) -> Vec<u8>;

    fn as_any(&self) -> &dyn Any;
}

pub struct Chain {
    pub encryptor: Vec<Box<dyn Operate>>,
    pub decryptor: Vec<Box<dyn Operate>>,
    pub input: Vec<u8>,
}

impl Chain {
    pub fn default(input: Vec<u8>) -> Self {
        Self {
            encryptor: Vec::new(),
            decryptor: Vec::new(),
            input,
        }
    }

    fn set_encryptor(&mut self, v: Vec<Box<dyn Operate>>) {
        let mut my_vec: Vec<Box<dyn Operate>> = Vec::new();
        for en in &v {
            if let Some(_xor) = en.as_any().downcast_ref::<XOROperator>() {
                my_vec.insert(
                    0,
                    Box::new(XOROperator {
                        key: _xor.key.clone(),
                    }),
                );
            } else {
                my_vec.insert(0, Box::new(NotOperator {}));
            }
        }
        self.encryptor = v;
        self.decryptor = my_vec;
    }

    fn add_encrypt_operator(&mut self, v: Box<dyn Operate>) {
        if let Some(_xor) = v.as_any().downcast_ref::<XOROperator>() {
            self.decryptor.insert(
                0,
                Box::new(XOROperator {
                    key: _xor.key.clone(),
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
}

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

pub struct NotOperator {}

impl Operate for NotOperator {
    fn operate(&self, d: &[u8]) -> Vec<u8> {
        d.iter().map(|&x1| !x1).collect::<Vec<u8>>()
    }

    fn as_any(&self) -> &dyn Any {
        self
    }
}

#[test]
fn test_chain() {
    let c = XOROperator {
        key: "rfgbh12345".to_string().into_bytes(),
    };

    let c2 = NotOperator {};

    let mut chain = Chain::default("abc123ghj6".to_string().into_bytes());

    chain.add_encrypt_operator(Box::new(c));
    chain.add_encrypt_operator(Box::new(c2));

    let r = chain.encrypt();

    println!("{:?}", r);

    println!("len {:?}", chain.decryptor.len());

    let result = chain.decrypt();

    println!("{:?}", String::from_utf8(result));
}
