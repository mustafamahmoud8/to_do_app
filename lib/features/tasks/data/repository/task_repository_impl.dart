import 'package:to_do_app/features/tasks/data/datasource/task_local_data_source.dart';
import 'package:to_do_app/features/tasks/data/models/task_hive_model.dart';
import 'package:to_do_app/features/tasks/domain/entity/task_entity.dart';
import 'package:to_do_app/features/tasks/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);
  @override
  Future<void> addTask(TaskEntity task) async{
    final taskModel = TaskHiveModel.fromEntity(task);
    await localDataSource.addTask(taskModel);
  }

  @override
  Future<void> clearBox() async{
    await localDataSource.clearBox();
  }

  @override
  Future<void> deleteTask(String uid) async{
    await localDataSource.deleteTask(uid);
  }

  @override
  Future<void> editTask(TaskEntity task) async{
    final taskModel = TaskHiveModel.fromEntity(task);
    await localDataSource.editTask(taskModel);
  }

  @override
  Future<List<TaskEntity>> getTasks() async{
    final tasks = await localDataSource.getTasks();
    return tasks.map((task)=>task.toEntity()).toList();
  }

}