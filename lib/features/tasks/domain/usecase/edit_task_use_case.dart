import 'package:to_do_app/features/tasks/domain/entity/task_entity.dart';
import 'package:to_do_app/features/tasks/domain/repository/task_repository.dart';

class EditTaskUseCase {
  final TaskRepository repository;

  EditTaskUseCase(this.repository);
  Future<void> call(TaskEntity task){
    return repository.editTask(task);
  }
}