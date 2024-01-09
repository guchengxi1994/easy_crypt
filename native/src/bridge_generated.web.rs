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
