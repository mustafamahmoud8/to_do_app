import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalTasksWidget extends StatelessWidget {
  const TotalTasksWidget({super.key, required this.totalTasks, required this.totalCompleted});
  final int totalTasks;
  final int totalCompleted;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 1.5,
            shadowColor: Colors.black.withValues(alpha: 0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12.r),
            ),
            color: Colors.deepPurpleAccent.withValues(alpha: 0.2),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.event_note_outlined,size: 28.sp,color: Colors.deepPurpleAccent,),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$totalTasks',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        Text(
                          'Total Tasks',
                           maxLines: 1,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            elevation: 1.5,
            shadowColor: Colors.black.withValues(alpha: 0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12.r),
            ),
            color: Colors.greenAccent.withValues(alpha: 0.2),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.event_note_outlined,size: 28.sp,color: Colors.green,),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$totalCompleted',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        Text(
                          'Completed Tasks',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
