import 'dart:async';

import 'package:easy_crypt/isar/database.dart';
import 'package:easy_crypt/isar/datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../models/datasource_state.dart';

class DatasourceNotifier extends AutoDisposeAsyncNotifier<DatasourceState> {
  final IsarDatabase database = IsarDatabase();

  @override
  FutureOr<DatasourceState> build() async {
    final l = await database.isar!.datasources.where().findAll();

    return DatasourceState(datasources: l);
  }
}

final datasourceItemsProvider =
    AutoDisposeAsyncNotifierProvider<DatasourceNotifier, DatasourceState>(
  () => DatasourceNotifier(),
);
