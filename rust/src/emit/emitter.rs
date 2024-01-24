use serde::Serialize;

pub trait Emitter {
    #[inline]
    fn to_json(&self) -> String
    where
        Self: Serialize,
    {
        serde_json::to_string(self).unwrap_or("".to_owned())
    }

    #[inline]
    fn send_message(&self)
    where
        Self: Serialize,
    {
        match super::MESSAGE_SINK.try_read() {
            Ok(s) => match s.as_ref() {
                Some(s0) => {
                    s0.add(self.to_json());
                }
                None => {
                    println!("[rust-error] Stream is None");
                }
            },
            Err(_) => {
                println!("[rust-error] Stream read error");
            }
        }
    }
}
