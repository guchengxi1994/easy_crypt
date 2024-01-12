import 'package:easy_crypt/layout/models/compress_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompressNotifier extends Notifier<CompressState> {
  @override
  CompressState build() {
    return CompressState(jobs: []);
  }
}

final compressProvider = NotifierProvider<CompressNotifier, CompressState>(
  () => CompressNotifier(),
);
