import 'package:easy_crypt/isar/datasource.dart';

class CachedDatasourceState {
  // List<Datasource> datasources;
  Datasource? left;
  Datasource? right;

  CachedDatasourceState({this.left, this.right});

  CachedDatasourceState copyWith(Datasource? left, Datasource? right) {
    return CachedDatasourceState(
        left: left ?? this.left, right: right ?? this.right);
  }
}
