import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/tasks/prsentation/cubit/task_cubit.dart';
import 'package:to_do_app/features/tasks/prsentation/widgets/tasks_view.dart';

import '../../../../core/dependency_injection/injection_container.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(_)=> sl<TaskCubit>()..getTasks(),
        child: TasksView(),
    );
  }
}
