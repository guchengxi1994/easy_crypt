pub mod base_trait;
pub mod cached;
pub mod local;
pub mod s3;

use std::sync::RwLock;

use once_cell::sync::Lazy;

use self::cached::CacheDatasources;

// a global `S3Client`
pub static S3CLIENT: Lazy<RwLock<Option<s3::S3Client>>> = Lazy::new(|| RwLock::new(None));

pub static DATASOURCES: Lazy<RwLock<CacheDatasources>> =
    Lazy::new(|| RwLock::new(CacheDatasources::default()));

pub enum EntryType {
    File,
    Folder,
}

pub struct Entry {
    pub _type: EntryType,
    pub path: String,
}
