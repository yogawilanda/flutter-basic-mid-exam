import 'package:flutter/material.dart';
import 'package:hello_flutter/view/pages/home/homepage_view.dart';
import 'package:hello_flutter/view/pages/home/main_app.dart';
import 'package:hello_flutter/view/pages/menu/menu_view.dart';

class TabBarFormatNavigation extends StatefulWidget {
  const TabBarFormatNavigation({super.key});

  @override
  State<TabBarFormatNavigation> createState() => _TabBarFormatNavigationState();
}

class _TabBarFormatNavigationState extends State<TabBarFormatNavigation>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void navigationDebugChecker() {
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        debugPrint("Tab Index: ${_tabController.index + 1}");
      } else {
        debugPrint("Tab Index: ${_tabController.index + 1}");
      }
    });
  }

  List<Widget> get tabs {
    const logo1 = Icon(Icons.directions_transit, color: Colors.white);
    const logo2 = Icon(Icons.directions_bike, color: Colors.white);
    const logo3 = Icon(Icons.directions_car, color: Colors.white);
    return [
      TabCustomWidget(title: "Beranda", icon: logo3),
      TabCustomWidget(title: "Widget", icon: logo2),
      TabCustomWidget(title: "Pengaturan", icon: logo1),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        bottom: TabBar(
          controller: _tabController,
          onTap: (index) {
            navigationDebugChecker();
          },
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MyHomePage(),
          Yoga_1201222013(),
          MenuView(),
        ],
      ),
    );
  }

  textTabContent(String text) {
    return Text(
      text,
      style: textStyle(Colors.white),
    );
  }

  textStyle(var colors) {
    return TextStyle(
      color: colors,
    );
  }
}

class TabCustomWidget extends StatelessWidget {
  TabCustomWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: icon,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
