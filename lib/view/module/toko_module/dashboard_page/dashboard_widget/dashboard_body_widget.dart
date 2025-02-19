import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardShopBodySection extends StatelessWidget {
  final List<String> menuList = [
    "Budgeting",
    "Transfer",
    "Withdraw",
    "Payment",
    "History",
    "Promo",
    "Help",
    "Setting",
  ];

  final List<IconData> iconList = [
    Icons.account_balance_wallet,
    Icons.account_balance,
    Icons.account_balance_wallet,
    Icons.payment,
    Icons.history,
    Icons.local_offer,
    Icons.help,
    Icons.settings,
  ];

  final List<String> routeList = [
    "/budgeting",
    "/transfer",
    "/withdraw",
    "/payment",
    "/history",
    "/promo",
    "/help",
    "/setting",
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: MediaQuery.of(context).size.width * 0.06,
          runSpacing: MediaQuery.of(context).size.width * 0.06,
          children: List.generate(menuList.length, (index) {
            return ServiceTile(
              title: menuList[index],
              icon: iconList[index],
              route: routeList[index],
            );
          }),
        ),
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  const ServiceTile({
    required this.title,
    required this.icon,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.width * 0.12,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 30, color: Colors.green),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}