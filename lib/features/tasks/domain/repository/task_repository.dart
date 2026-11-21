import 'package:to_do_app/features/tasks/domain/entity/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getTasks();
  Future<void> addTask(TaskEntity task);
  Future<void> editTask(TaskEntity task);
  Future<void> deleteTask(String uid);
  Future<void> clearBox();
}