import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/view/module/bottom_navigation_bar_page.dart';
import 'package:flutter_mid_basic_exam/view/module/budgeting_app/budgeting_add_budget_form.dart';
import 'package:flutter_mid_basic_exam/view/module/budgeting_app/dashboard_budgeting.dart';
import 'package:flutter_mid_basic_exam/view/module/budgeting_app/spending_detail.dart';
import 'package:flutter_mid_basic_exam/view/module/budgeting_app/spending_list.dart';
import 'package:flutter_mid_basic_exam/view/module/error/error_page.dart';
import 'package:flutter_mid_basic_exam/view/module/image_picker/media_picker.dart';
import 'package:flutter_mid_basic_exam/view/module/simple_todo_app/task_list_page.dart';
import 'package:flutter_mid_basic_exam/view/pages/home/main_app.dart';
import 'package:flutter_mid_basic_exam/view/widgets/tab_bar_format_navigation.dart';

class AppRoutes {
  static const String dashboardBudgetingApp = '/';
  static const String bottomNavigationBarExample =
      '/bottomNavigationBarExample';
  static const String mediaPicker = '/mediaPicker';
  static const String tabBarFormatNavigation = '/tabBarFormatNavigation';
  static const String taskListScreen = '/taskListScreen';
  static const String yoga = '/yoga';
  static const String budgeting = '/budgeting';
  static const String spendingListPage = '/spendingListPage';
  static const String spendingDetailsPage = '/spendingDetailsPage';


  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboardBudgetingApp:
        return MaterialPageRoute(builder: (context) => DashboardBudgetingApp());
      case budgeting:
        return MaterialPageRoute(builder: (context) => BudgetingForm());
      case spendingListPage:
        return MaterialPageRoute(builder: (context) => SpendingListPage());
      case spendingDetailsPage:
        return MaterialPageRoute(builder: (context) => SpendingDetailsPage(
        ));
      case bottomNavigationBarExample:
        return MaterialPageRoute(
            builder: (context) => const BottomNavigationBarExample());
      case mediaPicker:
        return MaterialPageRoute(builder: (context) => MediaPicker());
      case tabBarFormatNavigation:
        return MaterialPageRoute(
            builder: (context) => TabBarFormatNavigation());
      case taskListScreen:
        return MaterialPageRoute(builder: (context) => TaskListScreen());
      case yoga:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (context) => Yoga_1201222013(
            title: args['title']!,
            nama: args['nama']!,
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => const ErrorPages(),
    );
  }
}
