import 'package:flutter/material.dart';
import 'package:user_mortgage_app/view/module/bottom_navigation_bar_page.dart';
import 'package:user_mortgage_app/view/module/notification_widget_page.dart';
import 'package:user_mortgage_app/view/module/page_example_list_page.dart';
import 'package:user_mortgage_app/view/pages/auth/login/login_view.dart';



class MenuView extends StatelessWidget {
  const MenuView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Define the dynamic menu, description, and icons here
    List<String> menu = [
      "Account",
      "Dialogs",
      "Pages Example",
      "Notification Widget",
      "Navigation Bar Widget",
      "Setting",
      "Logout"
    ];

    List<String> description = [
      "Account Description",
      "Dialogs Description",
      "Pages Example Description",
      "Notification Widget Description",
      "Navigation Bar Widget Description",
      "Setting Description",
      "Logout Description"
    ];
    List<IconData> leadingIcon = [
      Icons.account_circle,
      Icons.widgets,
      Icons.pages,
      Icons.notifications,
      Icons.grid_view_sharp,
      Icons.settings,
      Icons.logout
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Option Menu",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: menu.length, // Use the length of the menu list
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: listTileCustom(
                    context, menu, description, leadingIcon, index),
              );
            },
          ),
        ],
      ),
    );
  }

  ListTile listTileCustom(BuildContext context, List<String> menu,
      List<String> description, List<IconData> leadingIcon, int index) {
    return ListTile(
      tileColor: Colors.green[400],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        menu[index],
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        description[index],
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      leading: Icon(
        leadingIcon[index],
        color: Colors.white,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
      ),
      onTap: () => _handleMenuAction(context, index, menu),
    );
  }

// Helper method to handle different menu actions
  void _handleMenuAction(
      BuildContext context, int index, List<String> menu) async {
    switch (index) {
      case 0:
        _showSnackBar(context, menu[index]);
        break;
      case 1:
        _showMaterialBanner(context, menu[index]);
        break;
      case 2:
        // _navigateToPage(context, const TaskListScreen());
        _navigateToPage(context, const PageExampleListPage());
        break;
      case 3:
        _navigateToPage(context, const NotificationWidgetPage());
        break;
      case 4:
        _navigateToPage(context, const BottomNavigationBarExample());
        break;
      case 5:
        _navigateToPage(context, LoginView(menu: menu[index]));
        break;
    }
  }

// Displays a SnackBar with the given message
  void _showSnackBar(BuildContext context, String menuName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("You clicked on $menuName")),
    );
  }

// Shows a MaterialBanner with a close button
  void _showMaterialBanner(BuildContext context, String menuName) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text("This is a banner for $menuName"),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

// Helper function to navigate to the specified page
  void _navigateToPage(BuildContext context, Widget page, {String? title}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => page, settings: RouteSettings(name: title)),
    );
  }

  Future<dynamic> popupsMethod(
      BuildContext context, List<String> menu, int index) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text("Settings Dialog"),
        content: Text("This is a dialog for ${menu[index]}"),
        actions: [
          TextButton(
            onPressed: () {
              debugPrint("Process");
            },
            child: Text("Process"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
