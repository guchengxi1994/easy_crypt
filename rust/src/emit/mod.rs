pub mod decrypt_message;
pub mod emitter;
pub mod encrypt_message;
pub mod file_transfer_message;
pub mod random_key_message;
pub mod two_datasource_transfer_message;
pub mod zip_file_message;

use std::sync::RwLock;

use crate::frb_generated::StreamSink;

pub static MESSAGE_SINK: RwLock<Option<StreamSink<String>>> = RwLock::new(None);
