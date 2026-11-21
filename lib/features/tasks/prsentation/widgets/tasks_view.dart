import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_app/features/tasks/prsentation/cubit/task_state.dart';
import 'package:to_do_app/features/tasks/prsentation/pages/add_edit_task_page.dart';
import 'package:to_do_app/features/tasks/prsentation/widgets/empty_tasks_widget.dart';
import 'package:to_do_app/features/tasks/prsentation/widgets/task_item.dart';
import 'package:to_do_app/features/tasks/prsentation/widgets/total_tasks_widget.dart';

import '../cubit/task_cubit.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do App'),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.w600),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
          builder: (context,state){
            if(state is TaskLoadingState){
              return Center(child: CircularProgressIndicator());
            }
            if(state is TaskSuccessState){
              final completedTasks = state.tasks.where((task)=>task.isCompleted).length;
              final totalTasks = state.tasks.length;
              if(state.tasks.isEmpty){
                return EmptyTasksWidget();
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TotalTasksWidget(totalTasks: totalTasks, totalCompleted: completedTasks),
                      SizedBox(height: 14.h,),
                      Text(
                        "Today's Tasks",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 14.h,),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index){
                            final task = state.tasks[index];
                            return TaskItem(task: task);
                          },
                          separatorBuilder:(context,index)=> SizedBox(height:2.h,),
                          itemCount: state.tasks.length
                      ),
                    ],
                  ),
                ),
              );
            }
            if(state is TaskErrorState){
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          }
      ),
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder:(_)=> BlocProvider.value(
                        value: context.read<TaskCubit>(),
                        child: const AddEditTaskPage(appBarTitle: 'Add Task',buttonText: 'Save Task',),
                    ),
                ),
            );
          },
          child: Center(child: Icon(Icons.add)),
      ),
    );
  }
}
