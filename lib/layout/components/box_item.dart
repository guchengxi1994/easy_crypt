import 'package:easy_crypt/layout/models/job_state.dart';
import 'package:flutter/material.dart';

class BoxItem<T extends Job> extends StatelessWidget {
  const BoxItem({super.key, required this.data});
  final T data;

  @override
  Widget build(BuildContext context) {
    if (data is UploadJob) {
      return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
              child: Text(
                (data as UploadJob).filePath ?? "",
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: SizedBox(
                    height: 5,
                    child: LinearProgressIndicator(
                      color: Colors.blueAccent,
                      value: (data as UploadJob).progress,
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    (data as UploadJob).transferSpeed ?? "",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    return Container();
  }
}
