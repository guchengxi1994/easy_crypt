import 'package:easy_crypt/isar/datasource.dart';

class DatasourceState {
  List<Datasource> datasources;

  DatasourceState({required this.datasources});

  DatasourceState copyWith({List<Datasource>? datasources}) {
    return DatasourceState(datasources: datasources ?? this.datasources);
  }
}
