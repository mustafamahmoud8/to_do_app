import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/features/tasks/prsentation/pages/task_page.dart';

import 'core/services/app_initializer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurpleAccent),
          ),
          home: const TaskPage(),
        );
      },

    );
  }
}

