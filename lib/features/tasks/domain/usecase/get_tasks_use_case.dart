import 'package:to_do_app/features/tasks/domain/entity/task_entity.dart';
import 'package:to_do_app/features/tasks/domain/repository/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);
  Future<List<TaskEntity>> call(){
    return repository.getTasks();
  }
}