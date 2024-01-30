import 'dart:async';

import 'package:easy_crypt/file_system/enum.dart';
import 'package:easy_crypt/file_system/models/local_state.dart';
import 'package:easy_crypt/src/rust/api/datasource.dart';
import 'package:easy_crypt/src/rust/process/datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_crypt/src/rust/api/datasource.dart' as ds;
import 'cached_datasource_notifier.dart';

class LocalNotifier extends AutoDisposeFamilyAsyncNotifier<LocalState, String> {
  final String path;
  final PreviewType? previewType;
  LocalNotifier({required this.path, required this.previewType});

  refresh(List<Entry> entries, String router) async {
    final routers0 = router.split("/");
    String router0;
    if (routers0.length >= 2) {
      router0 = routers0.sublist(routers0.length - 2).join("/");
    } else {
      router0 = routers0.join("/");
    }
    final List<String> routers = List.from(state.value!.routers)..add(router0);
    state = await AsyncValue.guard(
      () async {
        return LocalState(entries: entries, routers: routers);
      },
    );
  }

  refreshCurrent(int leftOrRight) async {
    List<String> routers = List.from(state.value!.routers);
    if (leftOrRight == 1) {
      final left = ref.read(cachedProvider.notifier).findLeft();

      if (left != null) {
        final list = await listObjectsLeft(p: routers.join("/"));
        if (list.isNotEmpty) {
          // refresh(list, routers.last);
          state = await AsyncValue.guard(
            () async {
              return LocalState(entries: list, routers: routers);
            },
          );
        }
      }
    } else {
      final right = ref.read(cachedProvider.notifier).findRight();
      if (right != null) {
        final list = await listObjectsRight(p: routers.last);
        if (list.isNotEmpty) {
          // refresh(list, routers.last);
          state = await AsyncValue.guard(
            () async {
              return LocalState(entries: list, routers: routers);
            },
          );
        }
      }
    }
  }

  prev(/* left = 1, right = 0 */ int leftOrRight) async {
    List<String> routers = List.from(state.value!.routers);
    print(routers);
    if (routers.length <= 1) {
      return;
    }
    routers.removeLast();
    if (leftOrRight == 1) {
      final left = ref.read(cachedProvider.notifier).findLeft();

      if (left != null) {
        final list = await listObjectsLeft(p: routers.join("/"));
        if (list.isNotEmpty) {
          // refresh(list, routers.last);
          state = await AsyncValue.guard(
            () async {
              return LocalState(entries: list, routers: routers);
            },
          );
        }
      }
    } else {
      final right = ref.read(cachedProvider.notifier).findRight();
      if (right != null) {
        final list = await listObjectsRight(p: routers.last);
        if (list.isNotEmpty) {
          // refresh(list, routers.last);
          state = await AsyncValue.guard(
            () async {
              return LocalState(entries: list, routers: routers);
            },
          );
        }
      }
    }
  }

  @override
  FutureOr<LocalState> build(String arg) async {
    if (previewType == PreviewType.Left) {
      final list = await ds.listObjectsLeft(p: "/");
      return LocalState(entries: list, routers: ["/"]);
    } else {
      final list = await ds.listObjectsRight(p: "/");
      return LocalState(entries: list, routers: ["/"]);
    }
  }
}
