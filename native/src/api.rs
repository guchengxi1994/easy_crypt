use crate::emit::MESSAGE_SINK;
use flutter_rust_bridge::StreamSink;

pub fn test_encrypt() {
    let r = crate::tests::encrypt_file_stream();
    if let Ok(_) = r {
        println!("done");
    } else {
        println!("err {:?}", r.err());
    }
}

pub fn native_message_stream(s: StreamSink<String>) -> anyhow::Result<()> {
    let mut stream = MESSAGE_SINK.write().unwrap();
    *stream = Some(s);
    anyhow::Ok(())
}
