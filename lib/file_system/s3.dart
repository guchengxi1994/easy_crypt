import 'package:easy_crypt/file_system/components/title_bar.dart';
import 'package:easy_crypt/file_system/models/s3_state.dart';
import 'package:easy_crypt/file_system/notifiers/s3_notifier.dart';
import 'package:easy_crypt/src/rust/process/datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/file_widget.dart';

class S3FilePreview extends ConsumerWidget {
  S3FilePreview(
      {super.key,
      required this.accesskey,
      required this.bucketname,
      required this.endpoint,
      required this.sessionToken,
      required this.sessionkey,
      this.height,
      this.width,
      this.region = "cn-shanghai"});
  final String endpoint;
  final String accesskey;
  final String sessionkey;
  final String bucketname;
  final String? sessionToken;
  final String region;
  final double? width;
  final double? height;

  late final s3Provider = AutoDisposeAsyncNotifierProvider<S3Notifier, S3State>(
      () => S3Notifier(
          accesskey: accesskey,
          bucketname: bucketname,
          endpoint: endpoint,
          sessionToken: sessionToken,
          sessionkey: sessionkey));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(s3Provider);

    return Material(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: width ?? 0.8 * MediaQuery.of(context).size.width,
        height: height ?? 0.8 * MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.white),
        child: Builder(builder: (c) {
          return switch (state) {
            AsyncValue<S3State>(:final value?) => Column(
                children: [
                  TitleBar(
                    routers: value.routers,
                    onPrevClick: () {
                      ref.read(s3Provider.notifier).prev();
                    },
                    onIndexedItemClicked: (index) {
                      ref.read(s3Provider.notifier).skipTo(index);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(child: _buildContent(value.entries, ref))
                ],
              ),
            _ => const Center(
                child: CircularProgressIndicator(),
              ),
          };
        }),
      ),
    );
  }

  Widget _buildContent(List<Entry> entries, WidgetRef ref) {
    if (entries.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: 200,
            child: Image.asset("assets/images/error.png"),
          ),
          const Text("Opps, something is wrong")
        ],
      );
    }

    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: entries
            .map((e) => FileWidget(
                  entry: e,
                  onDoubleClick: () {
                    if (e.type == EntryType.folder) {
                      ref.read(s3Provider.notifier).navigateTo(e.path);
                    }
                  },
                ))
            .toList(),
      ),
    );
  }
}
