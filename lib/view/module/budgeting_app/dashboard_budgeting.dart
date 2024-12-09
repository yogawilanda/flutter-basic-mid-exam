import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/controller/budgeting_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardBudgetingApp extends StatefulWidget {
  final String? username;
  final int _balance = 1000000;

  DashboardBudgetingApp({super.key, this.username});

  @override
  State<DashboardBudgetingApp> createState() => _DashboardBudgetingAppState();
}

class _DashboardBudgetingAppState extends State<DashboardBudgetingApp> {
  @override
  Widget build(BuildContext context) {
    final budgetingController = Provider.of<BudgetingController>(context);
    final balanceToFrontEnd =
        widget._balance + budgetingController.availableBalance.toInt();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.3),
        child: DashboardAppBar(username: widget.username ?? "John Doe"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ServicesCard(),
            SpendingListCard(balanceToFrontEnd: balanceToFrontEnd),
          ],
        ),
      ),
    );
  }
}

class DashboardAppBar extends StatelessWidget {
  final String username;

  const DashboardAppBar({required this.username});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          image: DecorationImage(
            image: AssetImage("assets/image/bg_dashboard.png"),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Header(username: username),
            const Spacer(),
            const UserBalanceCard(balanceToFrontEnd: 1000000),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String username;

  const Header({required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
            ),
            Text(
              username,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.account_circle,
            color: Colors.green,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class UserBalanceCard extends StatelessWidget {
  final int balanceToFrontEnd;

  const UserBalanceCard({super.key, required this.balanceToFrontEnd});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BalanceDetails(balanceToCard: balanceToFrontEnd),
            BalanceChart(),
          ],
        ),
      ),
    );
  }
}

class BalanceDetails extends StatelessWidget {
  final int balanceToCard;

  const BalanceDetails({required this.balanceToCard});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rp. ${balanceToCard.toString().replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (Match m) => '${m[1]}.',
              )}",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Available Balance",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        BalanceInfoRow(
          circleText: "Spent",
          title: "Rp 500.000",
          circleColor: Colors.orange,
        ),
        BalanceInfoRow(
          circleText: "Income",
          title: "Rp 500.000",
          circleColor: Colors.green,
        ),
      ],
    );
  }
}

class BalanceChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: MediaQuery.of(context).size.width * 0.15,
      backgroundColor: Colors.green,
      child: Icon(
        Icons.account_balance_wallet,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}

class BalanceInfoRow extends StatelessWidget {
  final String circleText;
  final String title;
  final Color circleColor;

  const BalanceInfoRow({
    required this.circleText,
    required this.title,
    required this.circleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(radius: 6, backgroundColor: circleColor),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                circleText,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ServicesCard extends StatelessWidget {
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

class SpendingListCard extends StatelessWidget {
  final int balanceToFrontEnd;

  const SpendingListCard({required this.balanceToFrontEnd});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpendingListHeader(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) => SpendingTile(),
            ),
          ],
        ),
      ),
    );
  }
}

class SpendingListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Spending List",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/spendingListPage");
          },
          child: Text(
            "See All",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}

class SpendingTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.orange,
        child: Icon(Icons.shopping_cart, color: Colors.white),
      ),
      title: Text("Spending Name", style: GoogleFonts.poppins(fontSize: 14)),
      subtitle: Text("Date", style: GoogleFonts.poppins(fontSize: 12)),
      trailing: Text(
        "- Rp. 100.000",
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.red),
      ),
    );
  }
}
