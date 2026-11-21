import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/constant/custom_text_field.dart';
import 'package:to_do_app/core/constant/primary_button.dart';
import 'package:to_do_app/features/tasks/prsentation/cubit/task_cubit.dart';
import 'package:to_do_app/features/tasks/prsentation/cubit/task_state.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entity/task_entity.dart';

class AddEditTaskPage extends StatefulWidget {
  const AddEditTaskPage({
    super.key,
    this.title,
    this.description,
    this.completed,
    required this.appBarTitle,
    required this.buttonText,
    this.uid,
  });
  final String? title;
  final String? description;
  final bool? completed;
  final String appBarTitle;
  final String buttonText;
  final String? uid;

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isCompleted = false;

  @override void initState() {
    super.initState();
    isCompleted = widget.completed ?? false;
    titleController.text = widget.title ?? '';
    descriptionController.text = widget.description ?? '';
  }
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.appBarTitle),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.w600),
      ),
      body: BlocConsumer<TaskCubit,TaskState>(
        listener: (context, state) {
          if (state is TaskSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  widget.buttonText == 'Add Task'
                      ? 'Task added successfully'
                      : 'Task updated successfully',
                ),
              ),
            );

            Navigator.pop(context);
          }

          if (state is TaskErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
          builder: (context,state){
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h,),
                      CustomTextField(
                          labelText: 'Title',
                          controller: titleController,
                          hintText: 'Enter task title',
                          validator: (value){
                            if(value == null ||  value.trim().isEmpty){
                              return 'Task Title Required';
                            }
                            return null;
                          },
                      ),
                      SizedBox(height: 14.h,),
                      CustomTextField(
                        labelText: 'Description (optional)',
                        minLiens: 4,
                        maxLines: 6,
                        controller: descriptionController,
                        hintText: 'Add a description',
                      ),
                      SizedBox(height: 14.h,),
                      Text(
                        'Status',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h,),
                      Row(
                        children: [
                          Expanded(
                              child: ChoiceChip(
                                  label: Text('Not Completed'),
                                  selected: !isCompleted,
                                  onSelected: (value){
                                    setState(() {
                                      isCompleted = false;
                                    });
                                  },
                                selectedColor: Colors.deepPurpleAccent.withValues(alpha: 0.2),
                                backgroundColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: !isCompleted
                                      ? Colors.black
                                      : Colors.grey[700],
                                  fontWeight: FontWeight.w600,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                          ),
                          if(widget.uid != null)
                          Expanded(
                            child: ChoiceChip(
                              label: Text('Completed'),
                              selected: isCompleted,
                              onSelected: (value){
                                setState(() {
                                  isCompleted = true;
                                });
                              },
                              selectedColor: Colors.deepPurpleAccent.withValues(alpha: 0.2),
                              backgroundColor: Colors.white,
                              labelStyle: TextStyle(
                                color: isCompleted
                                    ? Colors.black
                                    : Colors.grey[700],
                                fontWeight: FontWeight.w600,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60.h,),
                      PrimaryButton(
                          text: widget.buttonText,
                          onPressed: (){
                            if (formKey.currentState!.validate()) {
                              final task = TaskEntity(
                                uid: widget.uid ?? const Uuid().v4(),
                                title: titleController.text.trim(),
                                description: descriptionController.text.trim().isEmpty
                                    ? null
                                    : descriptionController.text.trim(),
                                isCompleted: isCompleted,
                              );

                              if (widget.uid == null) {
                                context.read<TaskCubit>().addTask(task);
                              } else {
                                context.read<TaskCubit>().editTask(task);
                              }
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
      ),
    );
  }
}
