use crate::{emit::MESSAGE_SINK, frb_generated::StreamSink};

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

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
