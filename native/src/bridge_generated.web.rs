use super::*;
// Section: wire functions

#[wasm_bindgen]
pub fn wire_test_encrypt(port_: MessagePort) {
    wire_test_encrypt_impl(port_)
}

#[wasm_bindgen]
pub fn wire_native_message_stream(port_: MessagePort) {
    wire_native_message_stream_impl(port_)
}

#[wasm_bindgen]
pub fn wire_default_key(port_: MessagePort) {
    wire_default_key_impl(port_)
}

#[wasm_bindgen]
pub fn wire_random_key(port_: MessagePort) {
    wire_random_key_impl(port_)
}

#[wasm_bindgen]
pub fn wire_encrypt(port_: MessagePort, save_dir: String, files: JsValue, key: String) {
    wire_encrypt_impl(port_, save_dir, files, key)
}

#[wasm_bindgen]
pub fn wire_compress(port_: MessagePort, paths: JsValue, save_dir: String) {
    wire_compress_impl(port_, paths, save_dir)
}

#[wasm_bindgen]
pub fn wire_flow_preview(port_: MessagePort, operators: JsValue) {
    wire_flow_preview_impl(port_, operators)
}

#[wasm_bindgen]
pub fn wire_init_s3_client(
    port_: MessagePort,
    endpoint: String,
    bucketname: String,
    access_key: String,
    session_key: String,
    session_token: Option<String>,
    region: String,
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

#[wasm_bindgen]
pub fn wire_upload_to_s3(port_: MessagePort, p: String, obj: String) {
    wire_upload_to_s3_impl(port_, p, obj)
}

#[wasm_bindgen]
pub fn wire_upload_to_s3_with_config(
    port_: MessagePort,
    endpoint: String,
    bucketname: String,
    access_key: String,
    session_key: String,
    session_token: Option<String>,
    region: String,
    p: String,
    obj: String,
) {
    wire_upload_to_s3_with_config_impl(
        port_,
        endpoint,
        bucketname,
        access_key,
        session_key,
        session_token,
        region,
        p,
        obj,
    )
}

#[wasm_bindgen]
pub fn wire_download_from_s3(port_: MessagePort, p: String, obj: String) {
    wire_download_from_s3_impl(port_, p, obj)
}

#[wasm_bindgen]
pub fn wire_generate_pregisn_url(
    port_: MessagePort,
    endpoint: String,
    bucketname: String,
    access_key: String,
    session_key: String,
    session_token: Option<String>,
    region: String,
    obj: String,
) {
    wire_generate_pregisn_url_impl(
        port_,
        endpoint,
        bucketname,
        access_key,
        session_key,
        session_token,
        region,
        obj,
    )
}

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for String {
    fn wire2api(self) -> String {
        self
    }
}
impl Wire2Api<Vec<String>> for JsValue {
    fn wire2api(self) -> Vec<String> {
        self.dyn_into::<JsArray>()
            .unwrap()
            .iter()
            .map(Wire2Api::wire2api)
            .collect()
    }
}
impl Wire2Api<EncryptItem> for JsValue {
    fn wire2api(self) -> EncryptItem {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        EncryptItem {
            file_path: self_.get(0).wire2api(),
            file_id: self_.get(1).wire2api(),
        }
    }
}

impl Wire2Api<Vec<EncryptItem>> for JsValue {
    fn wire2api(self) -> Vec<EncryptItem> {
        self.dyn_into::<JsArray>()
            .unwrap()
            .iter()
            .map(Wire2Api::wire2api)
            .collect()
    }
}
impl Wire2Api<Option<String>> for Option<String> {
    fn wire2api(self) -> Option<String> {
        self.map(Wire2Api::wire2api)
    }
}

impl Wire2Api<Vec<u8>> for Box<[u8]> {
    fn wire2api(self) -> Vec<u8> {
        self.into_vec()
    }
}
// Section: impl Wire2Api for JsValue

impl<T> Wire2Api<Option<T>> for JsValue
where
    JsValue: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        (!self.is_null() && !self.is_undefined()).then(|| self.wire2api())
    }
}
impl Wire2Api<String> for JsValue {
    fn wire2api(self) -> String {
        self.as_string().expect("non-UTF-8 string, or not a string")
    }
}
impl Wire2Api<i64> for JsValue {
    fn wire2api(self) -> i64 {
        ::std::convert::TryInto::try_into(self.dyn_into::<js_sys::BigInt>().unwrap()).unwrap()
    }
}
impl Wire2Api<u8> for JsValue {
    fn wire2api(self) -> u8 {
        self.unchecked_into_f64() as _
    }
}
impl Wire2Api<Vec<u8>> for JsValue {
    fn wire2api(self) -> Vec<u8> {
        self.unchecked_into::<js_sys::Uint8Array>().to_vec().into()
    }
}
