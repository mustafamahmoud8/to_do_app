class TaskEntity {
  final String uid;
  final String title;
  final String? description;
  final bool isCompleted;

  TaskEntity({
    required this.uid,
    required this.title,
    this.description,
    required this.isCompleted,
  });
}