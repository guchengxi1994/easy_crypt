use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_test_encrypt(port_: i64) {
    wire_test_encrypt_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_native_message_stream(port_: i64) {
    wire_native_message_stream_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_default_key(port_: i64) {
    wire_default_key_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_random_key(port_: i64) {
    wire_random_key_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_encrypt(
    port_: i64,
    save_dir: *mut wire_uint_8_list,
    files: *mut wire_list_encrypt_item,
    key: *mut wire_uint_8_list,
) {
    wire_encrypt_impl(port_, save_dir, files, key)
}

#[no_mangle]
pub extern "C" fn wire_compress(
    port_: i64,
    paths: *mut wire_StringList,
    save_dir: *mut wire_uint_8_list,
) {
    wire_compress_impl(port_, paths, save_dir)
}

#[no_mangle]
pub extern "C" fn wire_flow_preview(port_: i64, operators: *mut wire_StringList) {
    wire_flow_preview_impl(port_, operators)
}

#[no_mangle]
pub extern "C" fn wire_init_s3_client(
    port_: i64,
    endpoint: *mut wire_uint_8_list,
    bucketname: *mut wire_uint_8_list,
    access_key: *mut wire_uint_8_list,
    session_key: *mut wire_uint_8_list,
    session_token: *mut wire_uint_8_list,
    region: *mut wire_uint_8_list,
) {
    wire_init_s3_client_impl(
        port_,
        endpoint,
        bucketname,
        access_key,
        session_key,
        session_token,
        region,
    )
}

#[no_mangle]
pub extern "C" fn wire_upload_to_s3(
    port_: i64,
    p: *mut wire_uint_8_list,
    obj: *mut wire_uint_8_list,
) {
    wire_upload_to_s3_impl(port_, p, obj)
}

#[no_mangle]
pub extern "C" fn wire_download_from_s3(
    port_: i64,
    p: *mut wire_uint_8_list,
    obj: *mut wire_uint_8_list,
) {
    wire_download_from_s3_impl(port_, p, obj)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_StringList_0(len: i32) -> *mut wire_StringList {
    let wrap = wire_StringList {
        ptr: support::new_leak_vec_ptr(<*mut wire_uint_8_list>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_list_encrypt_item_0(len: i32) -> *mut wire_list_encrypt_item {
    let wrap = wire_list_encrypt_item {
        ptr: support::new_leak_vec_ptr(<wire_EncryptItem>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}
impl Wire2Api<Vec<String>> for *mut wire_StringList {
    fn wire2api(self) -> Vec<String> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}
impl Wire2Api<EncryptItem> for wire_EncryptItem {
    fn wire2api(self) -> EncryptItem {
        EncryptItem {
            file_path: self.file_path.wire2api(),
            file_id: self.file_id.wire2api(),
        }
    }
}

impl Wire2Api<Vec<EncryptItem>> for *mut wire_list_encrypt_item {
    fn wire2api(self) -> Vec<EncryptItem> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_StringList {
    ptr: *mut *mut wire_uint_8_list,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_EncryptItem {
    file_path: *mut wire_uint_8_list,
    file_id: i64,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_list_encrypt_item {
    ptr: *mut wire_EncryptItem,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

impl NewWithNullPtr for wire_EncryptItem {
    fn new_with_null_ptr() -> Self {
        Self {
            file_path: core::ptr::null_mut(),
            file_id: Default::default(),
        }
    }
}

impl Default for wire_EncryptItem {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
    unsafe {
        let _ = support::box_from_leak_ptr(ptr);
    };
}
