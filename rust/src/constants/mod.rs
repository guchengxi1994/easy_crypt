pub const ONE_MB: u64 = 1024 * 1024;
pub const AES_ENCRYPT_ONE_MB: u64 = 1048592;
pub const DEFAULT_AES_KEY: &str = "d651fc0a6658678be867ecf788aa8b69"; // md5 for "EasyCrypt"
/// s3 默认最小是5MB
pub const FIVE_MB: u64 = 5 * ONE_MB;
pub const SIXTEEN_MB: u64 = 16 * ONE_MB;
pub const CUSTOM_HEADER: &str = "THIS FILE IS ENCRYPTED BY EASY_CRYPT. DO NOT MODIFY"; // length 47

// MESSAGE TYPES
pub const TYPE_KEY: i8 = 0;
pub const TYPE_DECRYPT: i8 = 1;
pub const TYPE_ENCRYPT: i8 = 2;
pub const TYPE_ZIP_FILE: i8 = 3;
pub const TYPE_TRANSFER: i8 = 4;
pub const TYPE_TWO_DATASOURCE_TRANSFER: i8 = 5;
