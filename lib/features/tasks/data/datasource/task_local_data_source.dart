import 'package:to_do_app/features/tasks/data/models/task_hive_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskHiveModel>> getTasks();
  Future<void> addTask(TaskHiveModel task);
  Future<void> editTask(TaskHiveModel task);
  Future<void> deleteTask(String uid);
  Future<void> clearBox();
}