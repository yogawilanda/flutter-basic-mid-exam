import 'package:flutter/material.dart';
import 'package:hello_flutter/controller/task_controller.dart';
import 'package:hello_flutter/controller/login_controller.dart';
import 'package:hello_flutter/controller/register_controller.dart';
import 'package:hello_flutter/view/module/bottom_navigation_bar_page.dart';
import 'package:hello_flutter/constants/theme.dart';
import 'package:hello_flutter/view/module/image_picker/media_picker.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => TaskController()),
      ChangeNotifierProvider(create: (context) => RegisterController()),
      ChangeNotifierProvider(create: (context) => LoginController()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tugas Kuliah',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: BottomNavigationBarExample(),
      // home: MediaPicker(),
      // home:  TabBarFormat(),
      // home: const TaskListScreen(),
      // home: const Yoga_1201222013(title: 'Welcome', nama: 'Jhon Doe'),
    );
  }
}
