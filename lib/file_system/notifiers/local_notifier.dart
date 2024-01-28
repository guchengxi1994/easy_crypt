import 'dart:async';

import 'package:easy_crypt/file_system/enum.dart';
import 'package:easy_crypt/file_system/models/local_state.dart';
import 'package:easy_crypt/src/rust/api/datasource.dart';
import 'package:easy_crypt/src/rust/process/datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_crypt/src/rust/api/datasource.dart' as ds;
import 'package:tuple/tuple.dart';
import 'cached_datasource_notifier.dart';

class LocalNotifier extends AutoDisposeAsyncNotifier<LocalState> {
  final String path;
  final PreviewType? previewType;
  LocalNotifier({required this.path, required this.previewType});

  @override
  FutureOr<LocalState> build() async {
    final i = await ds.addLocalDatasource(p: path);
    ref.read(cachedProvider.notifier).add(
        i,
        Tuple2(
            previewType == PreviewType.Left
                ? CachedDatasourceType.Left
                : CachedDatasourceType.Right,
            path));
    final list = await ds.listObjectsByIndex(index: i, p: "/");

    return LocalState(entries: list, routers: ["/"]);
  }

  refresh(List<Entry> entries, String router) async {
    final List<String> routers = List.from(state.value!.routers)..add(router);
    state = await AsyncValue.guard(
      () async {
        return LocalState(entries: entries, routers: routers);
      },
    );
  }

  prev(/* left = 1, right = 0 */ int leftOrRight) async {
    List<String> routers = List.from(state.value!.routers);
    if (routers.length <= 1) {
      return;
    }
    routers.removeLast();
    if (leftOrRight == 1) {
      final left = ref.read(cachedProvider.notifier).findLeft();
      if (left != null) {
        final list =
            await listObjectsByIndex(index: left.item1, p: routers.last);
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
        final list =
            await listObjectsByIndex(index: right.item1, p: routers.last);
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
}

// final localNotifier = AutoDisposeNotifierProvider<LocalNotifier, LocalState>(
//   () => LocalNotifier(),
// );
