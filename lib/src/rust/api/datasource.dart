// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.21.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import '../process/datasource.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Future<void> transferFromLeftToRight(
        {required int leftIndex,
        required int rightIndex,
        required String p,
        required String savePath,
        required bool autoEncrypt,
        dynamic hint}) =>
    RustLib.instance.api.transferFromLeftToRight(
        leftIndex: leftIndex,
        rightIndex: rightIndex,
        p: p,
        savePath: savePath,
        autoEncrypt: autoEncrypt,
        hint: hint);

Future<String> transferBetweenTwoDatasource(
        {required String p,
        required String savePath,
        required bool autoEncrypt,
        dynamic hint}) =>
    RustLib.instance.api.transferBetweenTwoDatasource(
        p: p, savePath: savePath, autoEncrypt: autoEncrypt, hint: hint);

Future<void> addLocalDatasourceWithType(
        {required String p, required DatasourcePreviewType t, dynamic hint}) =>
    RustLib.instance.api.addLocalDatasourceWithType(p: p, t: t, hint: hint);

Future<void> addS3DatasourceWithType(
        {required String endpoint,
        required String bucketname,
        required String accessKey,
        required String sessionKey,
        String? sessionToken,
        required String region,
        required DatasourcePreviewType t,
        dynamic hint}) =>
    RustLib.instance.api.addS3DatasourceWithType(
        endpoint: endpoint,
        bucketname: bucketname,
        accessKey: accessKey,
        sessionKey: sessionKey,
        sessionToken: sessionToken,
        region: region,
        t: t,
        hint: hint);

/// TODO 将 add datasource 转为
/// 添加到一个struct 中
/// 只有 left 和 right两个参数，
/// 这样实现更加简单
Future<int> addLocalDatasource({required String p, dynamic hint}) =>
    RustLib.instance.api.addLocalDatasource(p: p, hint: hint);

Future<int> addS3Datasource(
        {required String endpoint,
        required String bucketname,
        required String accessKey,
        required String sessionKey,
        String? sessionToken,
        required String region,
        dynamic hint}) =>
    RustLib.instance.api.addS3Datasource(
        endpoint: endpoint,
        bucketname: bucketname,
        accessKey: accessKey,
        sessionKey: sessionKey,
        sessionToken: sessionToken,
        region: region,
        hint: hint);

Future<List<Entry>> listObjectsByIndex(
        {required int index, required String p, dynamic hint}) =>
    RustLib.instance.api.listObjectsByIndex(index: index, p: p, hint: hint);

Future<List<Entry>> listObjectsLeft({required String p, dynamic hint}) =>
    RustLib.instance.api.listObjectsLeft(p: p, hint: hint);

Future<List<Entry>> listObjectsRight({required String p, dynamic hint}) =>
    RustLib.instance.api.listObjectsRight(p: p, hint: hint);

enum DatasourcePreviewType {
  left,
  right,
}
