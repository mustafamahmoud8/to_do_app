import 'package:to_do_app/features/tasks/domain/entity/task_entity.dart';
import 'package:to_do_app/features/tasks/domain/repository/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);
  Future<void> call(TaskEntity task){
    return repository.addTask(task);
  }
}