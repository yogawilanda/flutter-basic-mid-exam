import 'package:flutter/material.dart';

class NotificationWidgetPage extends StatelessWidget {
  const NotificationWidgetPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Widget yang wajib dibuat
    // Snackbar, Alert Dialog, Simple Dialog
    List<String> menu = [
      "Snackbar",
      "Banner",
      "Dialog Widget",
      "Simple Dialog",
      "Alert Dialog",
    ];
    List<String> description = [
      "Snackbar adalah notifikasi yang muncul di bawah aplikasi",
      "Banner adalah notifikasi yang muncul di atas aplikasi",
      "Dialog adalah notifikasi yang muncul di tengah aplikasi",
      "Simple Dialog adalah notifikasi yang muncul di tengah aplikasi (lebih sederhana)",
      "Alert Description"
    ];
    List<IconData> leadingIcon = [
      Icons.account_circle,
      Icons.widgets,
      Icons.notifications,
      Icons.settings,
      Icons.logout
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(menu[2]),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              menu[2],
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
      ),
    );
  }

  ListTile listTileCustom(BuildContext context, List<String> menu,
      List<String> description, List<IconData> leadingIcon, int index) {
    return ListTile(
      tileColor: Colors.green[400],
      // Border tile
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(menu[index],
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      subtitle: Text(description[index],
          style: const TextStyle(color: Colors.white, fontSize: 12)),
      leading: Icon(
        leadingIcon[index],
        color: Colors.white,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
      ),
      onTap: () {
        switch (index) {
          case 0: // Snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("You clicked on ${menu[index]}")),
            );
            break;
          case 1: // Banner
            ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                  content: Text("This is a banner for ${menu[index]}"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // close the Banner
                        ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner();
                      },
                      child: const Text("Close"),
                    ),
                  ]),
            );
            break;
          case 2: // Dialogs
            popupsMethod(context, menu, index);
            break;
          case 3: // Simple Dialog
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                title: Text("Simple Dialog"),
                children: [
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "This is a dialog for ${menu[index]}",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  SimpleDialogOption(
                    onPressed: () {
                      debugPrint("Process");
                    },
                    child: Text("Process"),
                  ),
                  SimpleDialogOption(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Close"),
                  ),
                ],
              ),
            );
            break;

          case 4: // third menu (Logout)

            break;
        }
      },
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
