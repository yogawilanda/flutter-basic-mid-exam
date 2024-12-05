import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/controller/task_controller/task_controller_libraries.dart';
import 'package:flutter_mid_basic_exam/routes/routes.dart';
import 'package:flutter_mid_basic_exam/view/module/dashboard/dashboard_banking.dart';
import 'package:flutter_mid_basic_exam/view/module/image_picker/media_picker.dart';
import 'package:flutter_mid_basic_exam/view/widgets/tab_bar_format_navigation.dart';

import 'package:provider/provider.dart';

import 'constants/theme.dart';
import 'controller/auth_controller/login_controller.dart';
import 'controller/auth_controller/register_controller.dart';
import 'controller/toko_controller.dart';
import 'view/module/simple_todo_app/task_list_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskController()),
        ChangeNotifierProvider(create: (context) => RegisterController()),
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => TokoController()),
      ],
      child: const MyApp(),
    ),
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
      home: DashboardBanking(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
