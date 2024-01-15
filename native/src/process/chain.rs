use std::any::Any;

pub trait Excute {
    fn excute(&self, d: &[u8]) -> Vec<u8>;

    fn as_any(&self) -> &dyn Any;
}

pub struct Chain {
    pub encryptor: Vec<Box<dyn Excute>>,
    pub decryptor: Vec<Box<dyn Excute>>,
    pub input: Vec<u8>,
    output: Vec<u8>,
}

impl Chain {
    pub fn encrypt(&mut self) {
        if self.encryptor.is_empty() {
            self.output = self.input.clone();
            return;
        }
        let mut my_vec: Vec<Box<dyn Excute>> = Vec::new();

        /// TODO remove clone
        let mut result = self.input.clone();

        for en in &self.encryptor {
            if let Some(_xor) = en.as_any().downcast_ref::<XORExcutor>() {
                my_vec.insert(
                    0,
                    Box::new(XORExcutor {
                        key: _xor.key.clone(),
                    }),
                );
            } else {
                my_vec.insert(0, Box::new(NotExcutor {}));
            }

            result = en.excute(&result).to_vec();
        }
        self.output = result;
        self.decryptor = my_vec;
    }

    pub fn decrypt(&mut self) -> Vec<u8> {
        /// TODO remove clone
        let mut result = self.output.clone();
        for en in &self.decryptor {
            result = en.excute(&result).to_vec();
        }
        result
    }
}

pub struct XORExcutor {
    pub key: Vec<u8>,
}

impl Excute for XORExcutor {
    fn excute(&self, d: &[u8]) -> Vec<u8> {
        d.iter()
            .zip(self.key.iter())
            .map(|(&x1, &x2)| x1 ^ x2)
            .collect::<Vec<u8>>()
    }

    fn as_any(&self) -> &dyn Any {
        self
    }
}

pub struct NotExcutor {}

impl Excute for NotExcutor {
    fn excute(&self, d: &[u8]) -> Vec<u8> {
        d.iter().map(|&x1| !x1).collect::<Vec<u8>>()
    }

    fn as_any(&self) -> &dyn Any {
        self
    }
}

#[test]
fn test_chain() {
    let c = XORExcutor {
        key: "rfgbh12345".to_string().into_bytes(),
    };

    let c2 = NotExcutor {};
    let mut my_vec: Vec<Box<dyn Excute>> = Vec::new();
    my_vec.push(Box::new(c));
    my_vec.push(Box::new(c2));
    let mut chain = Chain {
        encryptor: my_vec,
        decryptor: Vec::new(),
        input: "abc123ghj6".to_string().into_bytes(),
        output: Vec::new(),
    };

    chain.encrypt();

    println!("{:?}", chain.output);

    println!("len {:?}", chain.decryptor.len());

    let result = chain.decrypt();

    println!("{:?}", String::from_utf8(result));
}
