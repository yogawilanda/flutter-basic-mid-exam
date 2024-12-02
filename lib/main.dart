import 'package:flutter/material.dart';
import 'package:hello_flutter/controller/task_controller.dart';
import 'package:hello_flutter/controller/login_controller.dart';
import 'package:hello_flutter/controller/register_controller.dart';
import 'package:hello_flutter/controller/toko_controller.dart';
import 'package:hello_flutter/view/module/bottom_navigation_bar_page.dart';
import 'package:hello_flutter/view/module/simple_todo_app/task_list_page.dart';
import 'package:hello_flutter/constants/theme.dart';
import 'package:hello_flutter/view/module/dashboard/dashboard_banking.dart';
import 'package:hello_flutter/view/module/dashboard/spending_detail.dart';
import 'package:hello_flutter/view/module/toko_module/customer_shop.dart';
import 'package:hello_flutter/view/module/image_picker/media_picker.dart';
import 'package:provider/provider.dart';

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
      home: TaskListScreen(),
      // home: const Yoga_1201222013(title: 'Welcome', nama: 'Jhon Doe'),
    );
  }
}
