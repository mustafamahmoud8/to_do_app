import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/features/tasks/domain/entity/task_entity.dart';

import '../cubit/task_cubit.dart';
import '../pages/add_edit_task_page.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key,required this.task});
  final TaskEntity task;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shadowColor: Colors.deepPurpleAccent.withValues(alpha: 0.08),
      color: task.isCompleted ? Colors.greenAccent.withValues(alpha: 0.2) : Colors.deepPurpleAccent.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(22.r),
      ),
      child: ListTile(
        leading: Checkbox(
            value: task.isCompleted,
            onChanged: null,
            shape: const CircleBorder(),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: task.isCompleted ? Colors.grey : Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationColor: Colors.grey,
            decorationThickness: 2,
          ),
        ),
        subtitle: Text(
          task.description ?? '',
          style: TextStyle(
            color: task.isCompleted
                ? Colors.grey[400]
                : Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          elevation: 4,
          color: Colors.white,
          onSelected: (value) {
            if (value == 'edit') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<TaskCubit>(),
                    child: AddEditTaskPage(
                      uid: task.uid,
                      title: task.title,
                      description: task.description,
                      completed: task.isCompleted,
                      appBarTitle: 'Edit Task',
                      buttonText: 'Save Changes',
                    ),
                  ),
                ),
              );
            } else if (value == 'delete') {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 8.h,
                    ),
                    actionsPadding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
                    title: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Delete Task',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    content: Text(
                      'Are you sure you want to delete this task?',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15.sp,
                        height: 1.4,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          context.read<TaskCubit>().deleteTask(task.uid);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(
                    Icons.edit_outlined,
                    size: 20.sp,
                    color: Colors.deepPurpleAccent,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(
                    Icons.delete_outline,
                    size: 20.sp,
                    color: Colors.redAccent,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

