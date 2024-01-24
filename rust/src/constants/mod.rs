pub const ONE_MB: u64 = 1024 * 1024;
pub const AES_ENCRYPT_ONE_MB: u64 = 1048592;
pub const DEFAULT_AES_KEY: &'static str = "d651fc0a6658678be867ecf788aa8b69"; // md5 for "EasyCrypt"
pub const SIXTEEN_MB: u64 = 16 * ONE_MB;
pub const CUSTOM_HEADER: &'static str = "THIS FILE IS ENCRYPTED BY EASY_CRYPT. DO NOT MODIFY"; // length 47

// MESSAGE TYPES
pub const TYPE_KEY: i8 = 0;
pub const TYPE_DECRYPT: i8 = 1;
pub const TYPE_ENCRYPT: i8 = 2;
pub const TYPE_ZIP_FILE: i8 = 3;
pub const TYPE_TRANSFER: i8 = 4;