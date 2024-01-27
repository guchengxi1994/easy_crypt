import 'package:easy_crypt/file_system/models/local_state.dart';
import 'package:easy_crypt/src/rust/process/datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalNotifier extends AutoDisposeNotifier<LocalState> {
  @override
  LocalState build() {
    return LocalState(entries: []);
  }

  refresh(List<Entry> entries, String router) {
    final List<String> routers = List.from(state.routers)..add(router);
    state = LocalState(entries: entries, routers: routers);
  }
}

final localNotifier = AutoDisposeNotifierProvider<LocalNotifier, LocalState>(
  () => LocalNotifier(),
);
