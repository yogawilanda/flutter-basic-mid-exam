import 'package:flutter/material.dart';
import 'package:user_mortgage_app/view/module/calculator/mortgage_calculator.dart';
import 'package:user_mortgage_app/view/module/calculator/mortgage_calculator_for_user.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key, required this.title});

  final String title;

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home', style: optionStyle),
    MortgageCalculator(),
    MortgageCalculatorForUser(),
    Text('School', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  double getDrawerWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Define a minimum width for mobile devices
    double minDrawerWidth = 56.0; // Suitable for icons on mobile

    // Define a percentage-based width for desktop devices
    double desktopDrawerWidth = screenWidth * 0.03; // 3% of screen width

    // Use the larger of the two values to ensure usability on both mobile and desktop
    return screenWidth < 600 ? minDrawerWidth : desktopDrawerWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(child: _widgetOptions[_selectedIndex]),
      drawer: Drawer(
        shape: Border.all(
          color: Colors.transparent,
          width: 2,
        ),
        width: getDrawerWidth(context),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             DrawerItem(
                  icon: Icons.home,
                  index: 0,
                  selectedIndex: _selectedIndex,
                  onTap: _onItemTapped,
                ),
                DrawerItem(
                  icon: Icons.calculate,
                  index: 1,
                  selectedIndex: _selectedIndex,
                  onTap: _onItemTapped,
                ),
                DrawerItem(
                  icon: Icons.person,
                  index: 2,
                  selectedIndex: _selectedIndex,
                  onTap: _onItemTapped,
                ),
                DrawerItem(
                  icon: Icons.info,
                  index: 3,
                  selectedIndex: _selectedIndex,
                  onTap: _onItemTapped,
                ),
            ],
          ),
        )),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int selectedIndex;
  final Function(int) onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Icon(icon),
      selected: selectedIndex == index,
      onTap: () {
        onTap(index);
        Navigator.pop(context);
      },
    );
  }
}
