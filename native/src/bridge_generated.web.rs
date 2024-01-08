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

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

// Section: impl Wire2Api for JsValue

impl<T> Wire2Api<Option<T>> for JsValue
where
    JsValue: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        (!self.is_null() && !self.is_undefined()).then(|| self.wire2api())
    }
}
