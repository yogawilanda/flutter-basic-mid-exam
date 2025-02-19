import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/view/module/toko_module/dashboard_page/dashboard_widget/dashboard_body_widget.dart';

import '../../budgeting_app/dashboard_budgeting.dart';

class DashboardShopPage extends StatefulWidget {
  final String username;

  const DashboardShopPage({super.key, required this.username});

  @override
  State<DashboardShopPage> createState() => _DashboardShopPageState();
}

class _DashboardShopPageState extends State<DashboardShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.35),
        child: DashboardAppBar(username: widget.username),
      ),
      body: Center(
        child: Column(
            children: [
              DashboardShopBodySection(),
            ]),
      ),
    );
  }
}
