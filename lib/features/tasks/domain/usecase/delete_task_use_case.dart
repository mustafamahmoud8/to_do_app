import 'package:to_do_app/features/tasks/domain/repository/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  Future<void> call(String uid){
    return repository.deleteTask(uid);
  }
}