import 'package:easy_crypt/layout/models/job_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobNotifier extends Notifier<JobState> {
  @override
  JobState build() {
    return JobState(jobs: []);
  }

  addJob<T extends Job>(T t) {
    List<Job> l = state.jobs..add(t);

    state = JobState(jobs: l);
  }

  update<T extends Job>(T t) {
    int index = state.jobs.indexOf(t);
    if (index != -1) {
      List<Job> l = state.jobs..replaceRange(index, index + 1, [t]);
      state = JobState(jobs: l);
    } else {
      addJob(t);
    }
  }

  clear() {
    state = JobState(jobs: []);
  }
}

final jobProvider = NotifierProvider<JobNotifier, JobState>(
  () => JobNotifier(),
);
