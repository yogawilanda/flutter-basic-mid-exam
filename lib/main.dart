import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/controller/budgeting_controller.dart';
import 'package:flutter_mid_basic_exam/controller/task_controller/task_controller_libraries.dart';
import 'package:flutter_mid_basic_exam/routes/routes.dart';
import 'package:flutter_mid_basic_exam/view/module/api_app/api_app_example.dart';
import 'package:flutter_mid_basic_exam/view/module/bottom_navigation_bar_page.dart';
import 'package:flutter_mid_basic_exam/view/module/budgeting_app/dashboard_budgeting.dart';
import 'package:flutter_mid_basic_exam/view/module/calculator/mortgage_calculator.dart';
import 'package:flutter_mid_basic_exam/view/module/contoh_load_json.dart';
import 'package:flutter_mid_basic_exam/view/module/image_picker/media_picker.dart';
import 'package:flutter_mid_basic_exam/view/module/local_notification_example.dart';
import 'package:flutter_mid_basic_exam/view/module/pageview_example.dart';
import 'package:flutter_mid_basic_exam/view/module/simple_todo_app/task_list_page.dart';
import 'package:flutter_mid_basic_exam/view/module/toko_module/transaction_page/customer_shop.dart';
// import 'package:flutter_mid_basic_exam/view/module/toko_module/dashboard/dashboard_shop_page.dart';
import 'package:flutter_mid_basic_exam/view/pages/menu/menu_view.dart';
import 'package:flutter_mid_basic_exam/view/widgets/tab_bar_format_navigation.dart';

import 'package:provider/provider.dart';

import 'constants/theme.dart';
import 'controller/auth_controller/login_controller.dart';
import 'controller/auth_controller/register_controller.dart';
import 'controller/toko_controller.dart';

void main() async {
  // Ensure widget binding before initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the notification service
  await NotificationService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskController()),
        ChangeNotifierProvider(create: (context) => RegisterController()),
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => TokoController()),
        ChangeNotifierProvider(create: (context) => BudgetingController()),
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
      title: 'Hitung',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      // home: DashboardBudgetingApp(),
      // home: LoadJSONExample(),
      // home: CustomerShop(), //tampilan customer
      // home : DashboardShopPage(username: "John Doe"), //tampilan toko
      // home : ApiPage(),
      // home: TabBarFormatNavigation(),
      home: MortgageCalculator(),
      // home : PageviewExample(),
      // home : MediaPicker(),
      // home : TaskListScreen(),
      // home : BottomNavigationBarExample(),
      // home : MenuView(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
