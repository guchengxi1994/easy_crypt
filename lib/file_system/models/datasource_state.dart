import 'package:easy_crypt/isar/datasource.dart';

class CachedDatasourceState {
  // List<Datasource> datasources;
  Datasource? left;
  Datasource? right;

  CachedDatasourceState({this.left, this.right});
}

class DatasourceState {
  List<Datasource> datasources;

  DatasourceState({required this.datasources});
}
