pub trait Excute {
    fn excute(&self, d: &[u8]) -> Vec<u8>;
}

pub struct Chain<T>
where
    T: Excute,
{
    pub encryptor: Vec<T>,
    pub decryptor: Vec<T>,
    pub input: Vec<u8>,
    output: Vec<u8>,
}

impl<T> Chain<T>
where
    T: Excute,
{
    pub fn enctypt(&mut self) {
        if self.encryptor.is_empty() {
            self.output = self.input.clone();
            return;
        }
        for en in &self.encryptor {
            self.output = en.excute(&self.input).to_vec();
        }
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
}

#[test]
fn test_chain() {
    let c = XORExcutor {
        key: "rfgbh12345".to_string().into_bytes(),
    };

    let mut chain = Chain {
        encryptor: vec![c],
        decryptor: Vec::new(),
        input: "abc123ghj6".to_string().into_bytes(),
        output: Vec::new(),
    };

    chain.enctypt();

    println!("{:?}", chain.output) 
}
