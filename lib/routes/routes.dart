import 'package:flutter/material.dart';
import 'package:user_mortgage_app/view/module/bottom_navigation_bar_page.dart';
import 'package:user_mortgage_app/view/module/budgeting_app/backup_dashboard_budgeting.dart';
import 'package:user_mortgage_app/view/module/budgeting_app/budgeting_add_budget_form.dart';
import 'package:user_mortgage_app/view/module/budgeting_app/spending_detail.dart';
import 'package:user_mortgage_app/view/module/budgeting_app/spending_list.dart';
import 'package:user_mortgage_app/view/module/error/error_page.dart';
import 'package:user_mortgage_app/view/module/image_picker/media_picker.dart';
import 'package:user_mortgage_app/view/module/simple_todo_app/task_list_page.dart';
import 'package:user_mortgage_app/view/pages/home/main_app.dart';
import 'package:user_mortgage_app/view/widgets/tab_bar_format_navigation.dart';


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
        return MaterialPageRoute(
          builder: (context) => SpendingDetailsPage(),
          settings: settings,
        );
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
        // return MaterialPageRoute(
        //   builder: (context) => DashboardBudgetingApp(),
        // );

        // return MaterialPageRoute(
        //   builder: (context) => MenuView(),
        // );
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => const ErrorPages(),
    );
  }
}
