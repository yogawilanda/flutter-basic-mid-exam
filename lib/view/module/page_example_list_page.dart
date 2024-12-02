import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_flutter/view/pages/auth/login/login_view.dart';
import 'package:hello_flutter/view/widgets/tab_bar_format_navigation.dart';
import 'package:hello_flutter/view/module/bottom_navigation_bar_page.dart';
import 'package:hello_flutter/view/module/notification_widget_page.dart';
import 'package:hello_flutter/view/module/simple_todo_app/task_list_page.dart';

class PageExampleListPage extends StatelessWidget {
  const PageExampleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the dynamic menu, description, and icons here
    List<String> menu = [
      "Simple Todo Apps",
      "Calculator",
      "Authentications Page",
      "Navigation Bar Widget",
      "Setting",
      "Logout"
    ];

    List<String> description = [
      "Aplikasi pencatatan sederhana",
      "Pages Example Description",
      "Notification Widget Description",
      "Navigation Bar Widget Description",
      "Setting Description",
      "Logout Description"
    ];

    List<IconData> leadingIcon = [
      Icons.widgets,
      Icons.pages,
      Icons.notifications,
      Icons.grid_view_sharp,
      Icons.settings,
      Icons.logout
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Page Example Menu",
          // style: Theme.of(context).textTheme.titleMedium,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              shrinkWrap: true,
              itemCount: menu.length, // Use the length of the menu list
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: GestureDetector(
                    onTap: () => _handleMenuAction(context, index, menu),
                    child: gridTileCustom(
                        context, menu, description, leadingIcon, index),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  GridTile gridTileCustom(BuildContext context, List<String> menu,
      List<String> description, List<IconData> leadingIcon, int index) {
    return GridTile(
      footer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              menu[index],
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.values[3],
                  letterSpacing: 1.1,
                ),
              ),
            ),
            Text(
              description[index],
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[400],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          leadingIcon[index],
          color: Colors.green[400],
          size: 48,
        ),
        // backgroundColor: Colors.green[400],
      ),
    );
  }

// Helper method to handle different menu actions
  void _handleMenuAction(
      BuildContext context, int index, List<String> menu) async {
    switch (index) {
      case 0:
        _navigateToPage(context, const TaskListScreen());
        break;
      case 1:
        _navigateToPage(context, const PageExampleListPage());
        break;
      case 2:
        _navigateToPage(context, LoginView(menu: menu[index]));
        break;
      case 3:
        _navigateToPage(context, const BottomNavigationBarExample());
        break;
      case 4:
        _navigateToPage(context, const NotificationWidgetPage());
        break;
    }
  }

// function to navigate to the specified page
  void _navigateToPage(BuildContext context, Widget page, {String? title}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => page, settings: RouteSettings(name: title)),
    );
  }

}
