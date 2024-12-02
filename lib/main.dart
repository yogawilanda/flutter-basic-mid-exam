import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/controller/task_controller.dart';

import 'package:provider/provider.dart';

import 'constants/theme.dart';
import 'controller/login_controller.dart';
import 'controller/register_controller.dart';
import 'controller/toko_controller.dart';
import 'view/module/simple_todo_app/task_list_page.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => TaskController()),
      ChangeNotifierProvider(create: (context) => RegisterController()),
      ChangeNotifierProvider(create: (context) => LoginController()),
      ChangeNotifierProvider(create: (context) => TokoController()),
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
      // routes: {
      //   // '/': (context) => BottomNavigationBarExample(),
      //   '/': (context) => DashboardBanking(),
      //   '/dashboard': (context) => DashboardBanking(),
      //   '/customer_shop': (context) => CustomerShop(),
      //   '/media_picker': (context) => MediaPicker(),
      //   '/spending_detail': (context) => SpendingDetailsPage(),
      // },
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(
      //       builder: (context) => BottomNavigationBarExample());
      // },
      // home : CustomerShop(),
      // home : DashboardBanking(),
      // home: BottomNavigationBarExample(),
      // home: MediaPicker(), // bukan untuk tugas uts
      // home:  TabBarFormat(),
      home: const TaskListScreen(),
      // home: const Yoga_1201222013(title: 'Welcome', nama: 'Jhon Doe'),
    );
  }
}
