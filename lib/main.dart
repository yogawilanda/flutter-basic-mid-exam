import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_mortgage_app/controller/budgeting_controller.dart';
import 'package:user_mortgage_app/controller/task_controller/task_controller_libraries.dart';
import 'package:user_mortgage_app/routes/routes.dart';
import 'package:user_mortgage_app/view/module/calculator/sidebar_widget.dart';
import 'package:user_mortgage_app/view/module/local_notification_example.dart';
import 'package:user_mortgage_app/view/module/responsive_layout/lib_layout.dart';
import 'package:user_mortgage_app/view/module/simple_todo_app/task_list_page.dart';
import 'package:user_mortgage_app/view/module/toko_module/dashboard_page/dashboard_shop_page.dart';
import 'package:user_mortgage_app/view/module/toko_module/product_management_page/add_product_form_page.dart';
import 'package:user_mortgage_app/view/module/toko_module/transaction_page/customer_shop.dart';
import 'package:user_mortgage_app/view/module/toko_module/transaction_page/daily_report_page.dart';
import 'package:user_mortgage_app/view/module/toko_module/transaction_page/splashscreen.dart';
import 'package:user_mortgage_app/view/module/toko_module/transaction_page/transaction_success.dart';
import 'package:user_mortgage_app/view/pages/auth/login/login_view.dart';

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
      theme: lightTheme(context),
      // home: DashboardBudgetingApp(),
      // home: LoadJSONExample(),
      home: CustomerShop(), //tampilan customer
      // home : TransactionDetailsPage(),
      // home: SplashScreen(), //splash screen
      // home: AddProductFormPage(),
      // home: DailyReportPage(
      //     report: DailyReport(
      //         date: DateTime.now(), totalSales: 200000, totalTransactions: 10)),
      // home : DashboardShopPage(username: "John Doe"), //tampilan toko
      // home : ApiPage(),
      // home: TabBarFormatNavigation(),
      // home: MortgageCalculator(),
      // home : SidebarWidget(title: "Real Estate Utility",),
      // home : PageviewExample(),
      // home : MediaPicker(),
      // home : TaskListScreen(),
      // home : BottomNavigationBarExample(),
      // home : MenuView(),
      // home: LoginView(menu: "Login", useAppBar: false),
      // home: MainLayout(
      //   desktopLayout: DesktopScreen(),
      //   mobileLayout: MobileScreen(
      //     useWidget: SidebarWidget(title: "Real Estate Utility"),
      //     isDefaultWidget: true,
      //   ),
      //   tabletLayout: TabletScreen(),
      // ),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
