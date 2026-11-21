import 'package:hive/hive.dart';
import 'package:to_do_app/features/tasks/data/datasource/task_local_data_source.dart';
import 'package:to_do_app/features/tasks/data/models/task_hive_model.dart';

class TaskLocalDataSourceImpl implements TaskLocalDataSource {

  final Box<TaskHiveModel> box;

  TaskLocalDataSourceImpl(this.box);
  @override
  Future<void> addTask(TaskHiveModel task)async {
    await box.put(task.uid, task);
  }

  @override
  Future<void> deleteTask(String uid)async {
    await box.delete(uid);
  }

  @override
  Future<void> editTask(TaskHiveModel task) async{
    await box.put(task.uid, task);
  }

  @override
  Future<List<TaskHiveModel>> getTasks() async{
    return box.values.toList();
  }

  @override
  Future<void> clearBox()async {
    await box.clear();
  }
}