import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/job_notifier.dart';
import 'box_item.dart';

class JobsBox extends ConsumerWidget {
  const JobsBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(jobProvider);

    return Visibility(
        visible: data.jobs.isNotEmpty,
        child: Container(
          // padding: const EdgeInsets.only(top: 10, bottom: 10),
          width: 300,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  offset: const Offset(0, 0),
                  blurRadius: 3,
                  spreadRadius: 3,
                ),
              ]),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      ref.read(jobProvider.notifier).clear();
                    },
                    child: const Icon(Icons.close),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (c, i) {
                  return BoxItem(
                    data: data.jobs[i],
                  );
                },
                itemCount: data.jobs.length,
              ))
            ],
          ),
        ));
  }
}
