import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/features/tasks/data/datasource/task_local_data_source.dart';
import 'package:to_do_app/features/tasks/data/datasource/task_local_data_source_impl.dart';
import 'package:to_do_app/features/tasks/prsentation/cubit/task_cubit.dart';

import '../../features/tasks/data/models/task_hive_model.dart';
import '../../features/tasks/data/repository/task_repository_impl.dart';
import '../../features/tasks/domain/repository/task_repository.dart';
import '../../features/tasks/domain/usecase/add_task_use_case.dart';
import '../../features/tasks/domain/usecase/delete_task_use_case.dart';
import '../../features/tasks/domain/usecase/edit_task_use_case.dart';
import '../../features/tasks/domain/usecase/get_tasks_use_case.dart';

final sl = GetIt.instance;

Future<void> setupDependencies()async{
  sl.registerLazySingleton<Box<TaskHiveModel>>(
        () => Hive.box<TaskHiveModel>('tasks'),
  );
  sl.registerLazySingleton<TaskLocalDataSource>(
      () => TaskLocalDataSourceImpl(sl())
  );
  sl.registerLazySingleton<TaskRepository>(
        () => TaskRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<GetTasksUseCase>(
        () => GetTasksUseCase(sl()),
  );

  sl.registerLazySingleton<AddTaskUseCase>(
        () => AddTaskUseCase(sl()),
  );

  sl.registerLazySingleton<EditTaskUseCase>(
        () => EditTaskUseCase(sl()),
  );

  sl.registerLazySingleton<DeleteTaskUseCase>(
        () => DeleteTaskUseCase(sl()),
  );
  sl.registerFactory<TaskCubit>(
      () => TaskCubit(
          sl(),
          sl(),
          sl(),
          sl(),
      ),
  );
}