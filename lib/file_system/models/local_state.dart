import 'package:easy_crypt/src/rust/process/datasource.dart';

class LocalState {
  List<Entry> entries;
  List<String> routers;

  LocalState({required this.entries, this.routers = const []});

  LocalState copyWith(List<String>? routers, List<Entry>? entries) {
    return LocalState(
      routers: routers ?? this.routers,
      entries: entries ?? this.entries,
    );
  }
}
