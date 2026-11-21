import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/tasks/domain/entity/task_entity.dart';
import 'package:to_do_app/features/tasks/domain/usecase/add_task_use_case.dart';
import 'package:to_do_app/features/tasks/domain/usecase/delete_task_use_case.dart';
import 'package:to_do_app/features/tasks/domain/usecase/edit_task_use_case.dart';
import 'package:to_do_app/features/tasks/domain/usecase/get_tasks_use_case.dart';
import 'package:to_do_app/features/tasks/prsentation/cubit/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final EditTaskUseCase editTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TaskCubit(
      this.getTasksUseCase,
      this.addTaskUseCase,
      this.editTaskUseCase,
      this.deleteTaskUseCase):super(TaskInitState());

  Future<void> getTasks()async{
    try{
      emit(TaskLoadingState());
      final tasks = await getTasksUseCase();
      emit(TaskSuccessState(tasks: tasks));
    }catch(e){
      emit(TaskErrorState(message: e.toString()));
    }
  }
  Future<void> addTask(TaskEntity task)async{
    try{
        emit(TaskActionLoadingState());
        await addTaskUseCase(task);
        final tasks = await getTasksUseCase();
        emit(TaskSuccessState(tasks: tasks));
    }catch(e){
      emit(TaskErrorState(message: e.toString()));
    }
  }
  Future<void> editTask(TaskEntity task)async{
    try{
      emit(TaskActionLoadingState());
      await editTaskUseCase(task);
      final tasks = await getTasksUseCase();
      emit(TaskSuccessState(tasks: tasks));
    }catch(e){
      emit(TaskErrorState(message: e.toString()));
    }
  }
  Future<void> deleteTask(String uid)async{
    try{
      await deleteTaskUseCase(uid);
      await getTasks();
    }catch(e){
      emit(TaskErrorState(message: e.toString()));
    }
  }

}