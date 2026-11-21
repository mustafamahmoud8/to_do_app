import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/features/tasks/data/models/task_hive_model.dart';

import '../dependency_injection/injection_container.dart';

class AppInitializer {
static Future<void>init()async{
  await Hive.initFlutter();
  Hive.registerAdapter(TaskHiveModelAdapter());
  await Hive.openBox<TaskHiveModel>('tasks');
  await setupDependencies();
}
}