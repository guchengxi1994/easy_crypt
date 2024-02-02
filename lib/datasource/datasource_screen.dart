import 'package:easy_crypt/datasource/components/datasource_widget.dart';
import 'package:easy_crypt/datasource/components/add_datasource_dialog.dart';
import 'package:easy_crypt/datasource/notifiers/datasource_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DatasourceScreen extends ConsumerStatefulWidget {
  const DatasourceScreen({super.key});

  @override
  ConsumerState<DatasourceScreen> createState() => _DatasourceScreenState();
}

class _DatasourceScreenState extends ConsumerState<DatasourceScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(datasourceProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: state.value!.datasources.isEmpty
            ? Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: Image.asset("assets/images/nodatasource.png"),
                    ),

                    /// TODO slang
                    const Text("You should add a datasource first")
                  ],
                ),
              )
            : Wrap(
                spacing: 20,
                runSpacing: 20,
                children: state.value!.datasources
                    .map((e) => DatasourceWidget(datasource: e))
                    .toList(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showGeneralDialog(
                barrierDismissible: true,
                barrierLabel: "add account",
                context: context,
                pageBuilder: (c, _, __) {
                  return const Center(
                    child: AddDatasourceDialog(),
                  );
                });
          },
          child: const Icon(Icons.add)),
    );
  }
}
