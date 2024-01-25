import 'dart:async';

import 'package:easy_crypt/file_system/models/s3_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class S3Notifier extends AutoDisposeAsyncNotifier<S3State> {
  final String endpoint;
  final String accesskey;
  final String sessionkey;
  final String bucketname;
  final String? sessionToken;
  final String region;
  S3Notifier(
      {required this.accesskey,
      required this.bucketname,
      required this.endpoint,
      required this.sessionToken,
      required this.sessionkey,
      this.region = "cn-shanghai"});

  @override
  FutureOr<S3State> build() async {
    S3State state = S3State(
        accesskey: accesskey,
        bucketname: bucketname,
        endpoint: endpoint,
        sessionToken: sessionToken,
        sessionkey: sessionkey);

    await state.getEntry();

    return state;
  }

  navigateTo(String path) async {
    List<String> routers = List.from(state.value!.routers);
    routers.add(path);
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      S3State state = S3State(
          routers: routers,
          accesskey: accesskey,
          bucketname: bucketname,
          endpoint: endpoint,
          sessionToken: sessionToken,
          sessionkey: sessionkey);

      await state.getEntry();

      return state;
    });
  }

  prev() async {
    List<String> routers = List.from(state.value!.routers);
    if (routers.length <= 1) {
      return;
    }

    routers.removeLast();

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      S3State state = S3State(
          routers: routers,
          accesskey: accesskey,
          bucketname: bucketname,
          endpoint: endpoint,
          sessionToken: sessionToken,
          sessionkey: sessionkey);

      await state.getEntry();

      return state;
    });
  }

  skipTo(int index) async {
    List<String> routers = List.from(state.value!.routers);
    final item = routers[index];
    if (item == routers.last) {
      return;
    }

    routers.removeRange(index + 1, routers.length);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      S3State state = S3State(
          routers: routers,
          accesskey: accesskey,
          bucketname: bucketname,
          endpoint: endpoint,
          sessionToken: sessionToken,
          sessionkey: sessionkey);

      await state.getEntry();

      return state;
    });
  }
}
