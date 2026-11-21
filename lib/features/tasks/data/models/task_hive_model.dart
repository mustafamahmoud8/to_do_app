
import 'package:hive/hive.dart';
import 'package:to_do_app/features/tasks/domain/entity/task_entity.dart';
part 'task_hive_model.g.dart';

@HiveType(typeId: 0)
class TaskHiveModel {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final bool isCompleted;

  TaskHiveModel({
    required this.uid,
    required this.title,
    this.description,
    required this.isCompleted,
  });

  factory TaskHiveModel.fromEntity(TaskEntity entity){
    return TaskHiveModel(
        uid: entity.uid,
        title: entity.title,
        description: entity.description,
        isCompleted: entity.isCompleted,
    );
  }
  TaskEntity toEntity(){
    return TaskEntity(
        uid: uid,
        title: title,
        description: description,
        isCompleted: isCompleted,
    );
  }
}