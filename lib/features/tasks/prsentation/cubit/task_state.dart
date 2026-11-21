import 'package:to_do_app/features/tasks/domain/entity/task_entity.dart';

abstract class TaskState {}
class TaskInitState extends TaskState{}
class TaskLoadingState extends TaskState{}
class TaskActionLoadingState extends TaskState {}
class TaskSuccessState extends TaskState{
  final List<TaskEntity> tasks;

  TaskSuccessState({required this.tasks});
}
class TaskErrorState extends TaskState{
  final String message;

  TaskErrorState({required this.message});
}