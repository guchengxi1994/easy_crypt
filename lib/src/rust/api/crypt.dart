// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.21.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import '../process/encrypt.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Future<String> defaultKey({dynamic hint}) =>
    RustLib.instance.api.defaultKey(hint: hint);

Future<String> randomKey({dynamic hint}) =>
    RustLib.instance.api.randomKey(hint: hint);

Future<String> encrypt(
        {required String saveDir,
        required List<EncryptItem> files,
        required String key,
        dynamic hint}) =>
    RustLib.instance.api
        .encrypt(saveDir: saveDir, files: files, key: key, hint: hint);

Future<String> decrypt(
        {required String saveDir,
        required String path,
        required String key,
        String? fileType,
        dynamic hint}) =>
    RustLib.instance.api.decrypt(
        saveDir: saveDir, path: path, key: key, fileType: fileType, hint: hint);

Future<String> compress(
        {required List<String> paths, required String saveDir, dynamic hint}) =>
    RustLib.instance.api.compress(paths: paths, saveDir: saveDir, hint: hint);

Future<List<String>> flowPreview(
        {required List<String> operators, dynamic hint}) =>
    RustLib.instance.api.flowPreview(operators: operators, hint: hint);