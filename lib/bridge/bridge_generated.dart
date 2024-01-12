// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.82.6.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty, unnecessary_const

import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';

import 'dart:ffi' as ffi;

abstract class Native {
  Future<void> testEncrypt({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kTestEncryptConstMeta;

  Stream<String> nativeMessageStream({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kNativeMessageStreamConstMeta;

  Future<String> defaultKey({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kDefaultKeyConstMeta;

  Future<String> randomKey({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kRandomKeyConstMeta;

  Future<String> encrypt(
      {required String saveDir,
      required List<EncryptItem> files,
      required String key,
      dynamic hint});

  FlutterRustBridgeTaskConstMeta get kEncryptConstMeta;

  Future<String> compress(
      {required List<String> paths, required String saveDir, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kCompressConstMeta;
}

class EncryptItem {
  final String filePath;
  final int fileId;

  const EncryptItem({
    required this.filePath,
    required this.fileId,
  });
}

class NativeImpl implements Native {
  final NativePlatform _platform;
  factory NativeImpl(ExternalLibrary dylib) =>
      NativeImpl.raw(NativePlatform(dylib));

  /// Only valid on web/WASM platforms.
  factory NativeImpl.wasm(FutureOr<WasmModule> module) =>
      NativeImpl(module as ExternalLibrary);
  NativeImpl.raw(this._platform);
  Future<void> testEncrypt({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_test_encrypt(port_),
      parseSuccessData: _wire2api_unit,
      parseErrorData: null,
      constMeta: kTestEncryptConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kTestEncryptConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "test_encrypt",
        argNames: [],
      );

  Stream<String> nativeMessageStream({dynamic hint}) {
    return _platform.executeStream(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_native_message_stream(port_),
      parseSuccessData: _wire2api_String,
      parseErrorData: _wire2api_FrbAnyhowException,
      constMeta: kNativeMessageStreamConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kNativeMessageStreamConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "native_message_stream",
        argNames: [],
      );

  Future<String> defaultKey({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_default_key(port_),
      parseSuccessData: _wire2api_String,
      parseErrorData: null,
      constMeta: kDefaultKeyConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kDefaultKeyConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "default_key",
        argNames: [],
      );

  Future<String> randomKey({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_random_key(port_),
      parseSuccessData: _wire2api_String,
      parseErrorData: null,
      constMeta: kRandomKeyConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kRandomKeyConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "random_key",
        argNames: [],
      );

  Future<String> encrypt(
      {required String saveDir,
      required List<EncryptItem> files,
      required String key,
      dynamic hint}) {
    var arg0 = _platform.api2wire_String(saveDir);
    var arg1 = _platform.api2wire_list_encrypt_item(files);
    var arg2 = _platform.api2wire_String(key);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_encrypt(port_, arg0, arg1, arg2),
      parseSuccessData: _wire2api_String,
      parseErrorData: null,
      constMeta: kEncryptConstMeta,
      argValues: [saveDir, files, key],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kEncryptConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "encrypt",
        argNames: ["saveDir", "files", "key"],
      );

  Future<String> compress(
      {required List<String> paths, required String saveDir, dynamic hint}) {
    var arg0 = _platform.api2wire_StringList(paths);
    var arg1 = _platform.api2wire_String(saveDir);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_compress(port_, arg0, arg1),
      parseSuccessData: _wire2api_String,
      parseErrorData: null,
      constMeta: kCompressConstMeta,
      argValues: [paths, saveDir],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kCompressConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "compress",
        argNames: ["paths", "saveDir"],
      );

  void dispose() {
    _platform.dispose();
  }
// Section: wire2api

  FrbAnyhowException _wire2api_FrbAnyhowException(dynamic raw) {
    return FrbAnyhowException(raw as String);
  }

  String _wire2api_String(dynamic raw) {
    return raw as String;
  }

  int _wire2api_u8(dynamic raw) {
    return raw as int;
  }

  Uint8List _wire2api_uint_8_list(dynamic raw) {
    return raw as Uint8List;
  }

  void _wire2api_unit(dynamic raw) {
    return;
  }
}

// Section: api2wire

@protected
int api2wire_u8(int raw) {
  return raw;
}

// Section: finalizer

class NativePlatform extends FlutterRustBridgeBase<NativeWire> {
  NativePlatform(ffi.DynamicLibrary dylib) : super(NativeWire(dylib));

// Section: api2wire

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_String(String raw) {
    return api2wire_uint_8_list(utf8.encoder.convert(raw));
  }

  @protected
  ffi.Pointer<wire_StringList> api2wire_StringList(List<String> raw) {
    final ans = inner.new_StringList_0(raw.length);
    for (var i = 0; i < raw.length; i++) {
      ans.ref.ptr[i] = api2wire_String(raw[i]);
    }
    return ans;
  }

  @protected
  int api2wire_i64(int raw) {
    return raw;
  }

  @protected
  ffi.Pointer<wire_list_encrypt_item> api2wire_list_encrypt_item(
      List<EncryptItem> raw) {
    final ans = inner.new_list_encrypt_item_0(raw.length);
    for (var i = 0; i < raw.length; ++i) {
      _api_fill_to_wire_encrypt_item(raw[i], ans.ref.ptr[i]);
    }
    return ans;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list_0(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }
// Section: finalizer

// Section: api_fill_to_wire

  void _api_fill_to_wire_encrypt_item(
      EncryptItem apiObj, wire_EncryptItem wireObj) {
    wireObj.file_path = api2wire_String(apiObj.filePath);
    wireObj.file_id = api2wire_i64(apiObj.fileId);
  }
}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint

/// generated by flutter_rust_bridge
class NativeWire implements FlutterRustBridgeWireBase {
  @internal
  late final dartApi = DartApiDl(init_frb_dart_api_dl);

  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  NativeWire(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  NativeWire.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void store_dart_post_cobject(
    DartPostCObjectFnType ptr,
  ) {
    return _store_dart_post_cobject(
      ptr,
    );
  }

  late final _store_dart_post_cobjectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(DartPostCObjectFnType)>>(
          'store_dart_post_cobject');
  late final _store_dart_post_cobject = _store_dart_post_cobjectPtr
      .asFunction<void Function(DartPostCObjectFnType)>();

  Object get_dart_object(
    int ptr,
  ) {
    return _get_dart_object(
      ptr,
    );
  }

  late final _get_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Handle Function(ffi.UintPtr)>>(
          'get_dart_object');
  late final _get_dart_object =
      _get_dart_objectPtr.asFunction<Object Function(int)>();

  void drop_dart_object(
    int ptr,
  ) {
    return _drop_dart_object(
      ptr,
    );
  }

  late final _drop_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.UintPtr)>>(
          'drop_dart_object');
  late final _drop_dart_object =
      _drop_dart_objectPtr.asFunction<void Function(int)>();

  int new_dart_opaque(
    Object handle,
  ) {
    return _new_dart_opaque(
      handle,
    );
  }

  late final _new_dart_opaquePtr =
      _lookup<ffi.NativeFunction<ffi.UintPtr Function(ffi.Handle)>>(
          'new_dart_opaque');
  late final _new_dart_opaque =
      _new_dart_opaquePtr.asFunction<int Function(Object)>();

  int init_frb_dart_api_dl(
    ffi.Pointer<ffi.Void> obj,
  ) {
    return _init_frb_dart_api_dl(
      obj,
    );
  }

  late final _init_frb_dart_api_dlPtr =
      _lookup<ffi.NativeFunction<ffi.IntPtr Function(ffi.Pointer<ffi.Void>)>>(
          'init_frb_dart_api_dl');
  late final _init_frb_dart_api_dl = _init_frb_dart_api_dlPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  void wire_test_encrypt(
    int port_,
  ) {
    return _wire_test_encrypt(
      port_,
    );
  }

  late final _wire_test_encryptPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_test_encrypt');
  late final _wire_test_encrypt =
      _wire_test_encryptPtr.asFunction<void Function(int)>();

  void wire_native_message_stream(
    int port_,
  ) {
    return _wire_native_message_stream(
      port_,
    );
  }

  late final _wire_native_message_streamPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_native_message_stream');
  late final _wire_native_message_stream =
      _wire_native_message_streamPtr.asFunction<void Function(int)>();

  void wire_default_key(
    int port_,
  ) {
    return _wire_default_key(
      port_,
    );
  }

  late final _wire_default_keyPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_default_key');
  late final _wire_default_key =
      _wire_default_keyPtr.asFunction<void Function(int)>();

  void wire_random_key(
    int port_,
  ) {
    return _wire_random_key(
      port_,
    );
  }

  late final _wire_random_keyPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_random_key');
  late final _wire_random_key =
      _wire_random_keyPtr.asFunction<void Function(int)>();

  void wire_encrypt(
    int port_,
    ffi.Pointer<wire_uint_8_list> save_dir,
    ffi.Pointer<wire_list_encrypt_item> files,
    ffi.Pointer<wire_uint_8_list> key,
  ) {
    return _wire_encrypt(
      port_,
      save_dir,
      files,
      key,
    );
  }

  late final _wire_encryptPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_list_encrypt_item>,
              ffi.Pointer<wire_uint_8_list>)>>('wire_encrypt');
  late final _wire_encrypt = _wire_encryptPtr.asFunction<
      void Function(
          int,
          ffi.Pointer<wire_uint_8_list>,
          ffi.Pointer<wire_list_encrypt_item>,
          ffi.Pointer<wire_uint_8_list>)>();

  void wire_compress(
    int port_,
    ffi.Pointer<wire_StringList> paths,
    ffi.Pointer<wire_uint_8_list> save_dir,
  ) {
    return _wire_compress(
      port_,
      paths,
      save_dir,
    );
  }

  late final _wire_compressPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64, ffi.Pointer<wire_StringList>,
              ffi.Pointer<wire_uint_8_list>)>>('wire_compress');
  late final _wire_compress = _wire_compressPtr.asFunction<
      void Function(
          int, ffi.Pointer<wire_StringList>, ffi.Pointer<wire_uint_8_list>)>();

  ffi.Pointer<wire_StringList> new_StringList_0(
    int len,
  ) {
    return _new_StringList_0(
      len,
    );
  }

  late final _new_StringList_0Ptr = _lookup<
          ffi.NativeFunction<ffi.Pointer<wire_StringList> Function(ffi.Int32)>>(
      'new_StringList_0');
  late final _new_StringList_0 = _new_StringList_0Ptr
      .asFunction<ffi.Pointer<wire_StringList> Function(int)>();

  ffi.Pointer<wire_list_encrypt_item> new_list_encrypt_item_0(
    int len,
  ) {
    return _new_list_encrypt_item_0(
      len,
    );
  }

  late final _new_list_encrypt_item_0Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_list_encrypt_item> Function(
              ffi.Int32)>>('new_list_encrypt_item_0');
  late final _new_list_encrypt_item_0 = _new_list_encrypt_item_0Ptr
      .asFunction<ffi.Pointer<wire_list_encrypt_item> Function(int)>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list_0(
    int len,
  ) {
    return _new_uint_8_list_0(
      len,
    );
  }

  late final _new_uint_8_list_0Ptr = _lookup<
          ffi
          .NativeFunction<ffi.Pointer<wire_uint_8_list> Function(ffi.Int32)>>(
      'new_uint_8_list_0');
  late final _new_uint_8_list_0 = _new_uint_8_list_0Ptr
      .asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  void free_WireSyncReturn(
    WireSyncReturn ptr,
  ) {
    return _free_WireSyncReturn(
      ptr,
    );
  }

  late final _free_WireSyncReturnPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(WireSyncReturn)>>(
          'free_WireSyncReturn');
  late final _free_WireSyncReturn =
      _free_WireSyncReturnPtr.asFunction<void Function(WireSyncReturn)>();
}

final class _Dart_Handle extends ffi.Opaque {}

final class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_EncryptItem extends ffi.Struct {
  external ffi.Pointer<wire_uint_8_list> file_path;

  @ffi.Int64()
  external int file_id;
}

final class wire_list_encrypt_item extends ffi.Struct {
  external ffi.Pointer<wire_EncryptItem> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_StringList extends ffi.Struct {
  external ffi.Pointer<ffi.Pointer<wire_uint_8_list>> ptr;

  @ffi.Int32()
  external int len;
}

typedef DartPostCObjectFnType = ffi.Pointer<
    ffi.NativeFunction<
        ffi.Bool Function(DartPort port_id, ffi.Pointer<ffi.Void> message)>>;
typedef DartPort = ffi.Int64;

const int ONE_MB = 1048576;

const int AES_ENCRYPT_ONE_MB = 1048592;

const int TYPE_KEY = 0;

const int TYPE_DECRYPT = 1;

const int TYPE_ENCRYPT = 2;

const int TYPE_ZIP_FILE = 3;
