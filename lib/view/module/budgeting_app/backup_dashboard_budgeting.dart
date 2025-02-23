import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_mortgage_app/controller/budgeting_controller.dart';
import 'package:user_mortgage_app/view/module/budgeting_app/spending_list.dart';

class DashboardBudgetingApp extends StatefulWidget {
  DashboardBudgetingApp({super.key, this.username});
  String? username;
  final int _balance = 1000000;
  @override
  State<DashboardBudgetingApp> createState() => _DashboardBudgetingAppState();
}

class _DashboardBudgetingAppState extends State<DashboardBudgetingApp> {
  @override
  Widget build(BuildContext context) {
    String username = "Jhon Doe";
    BudgetingController budgetingController =
        Provider.of<BudgetingController>(context);
    int balanceToFrontEnd =
        widget._balance + budgetingController.totalIncome.toInt();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.38),
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              // image
              image: DecorationImage(
                image: Image.asset("assets/image/bg_dashboard.png").image,
                fit: BoxFit.cover,
                // darken image
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.darken),
              ),
              // color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                ),
                const SizedBox(height: 20),
                cardUserBalanceInformation(),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardMenu(),
            spendingList(),
          ],
        ),
      ),
    );
  }

  cardUserBalanceInformation() {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(22),
        child: cardContent(),
      ),
    );
  }

  cardContent() {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rp. ${widget._balance.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                child: Text(
                  "Available Balance",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              cardInformation(),
              cardInformation(
                circleColor: Colors.green,
                title: "Rp 500.000",
                circleText: "Income",
              ),
            ],
          ),
          pieContainer(),
        ],
      ),
    );
  }

  pieContainer() {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 0),
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundColor: Color.fromRGBO(27, 181, 78, 1),
        child: Icon(
          Icons.account_balance_wallet,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  cardInformation({Color? circleColor, String? title, String? circleText}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 6,
              backgroundColor:
                  circleColor ?? const Color.fromARGB(255, 224, 123, 35),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Text(
                circleText ?? "Spent",
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
          title ?? "Rp 500.000",
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  userIdentity(String username) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              username,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 24,
          backgroundColor: Colors.green,
          child: Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 30,
          ),
        )
      ],
    );
  }

  cardMenu() {
    List<String> menuList = [
      "Budgeting",
      "Transfer",
      "Withdraw",
      "Payment",
      "History",
      "Promo",
      "Help",
      "Setting",
    ];

    List<IconData> iconList = [
      Icons.account_balance_wallet,
      Icons.account_balance,
      Icons.account_balance_wallet,
      Icons.payment,
      Icons.history,
      Icons.local_offer,
      Icons.help,
      Icons.settings,
    ];

    // Navigation Route
    List<String> routeList = [
      "/budgeting",
      "/transfer",
      "/withdraw",
      "/payment",
      "/history",
      "/promo",
      "/help",
      "/setting",
    ];

    return Card(
      elevation: 2,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: double.infinity,
        ),
        padding:
            const EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 16),
        margin: const EdgeInsets.only(top: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: titleCard(title: "Services"),
            ),
            Wrap(
              spacing: MediaQuery.of(context).size.width * 0.06,
              runSpacing: MediaQuery.of(context).size.width * 0.06,
              children: [
                // menu List
                for (var i = 0; i < 8; i++)
                  tileMenu(
                    titleMenuGrid: menuList[i],
                    iconMenuGrid: iconList[i],
                    route: routeList[i],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InkWell tileMenu({
    String? titleMenuGrid,
    IconData? iconMenuGrid,
    String? route,
  }) {
    return InkWell(
      onTap: () {
        debugPrint("Menu Clicked ${route ?? "/topup"}");
        Navigator.pushNamed(context, route ?? "/topup");
      },
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.width * 0.12,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconMenuGrid ?? Icons.account_balance_wallet,
                  size: 30,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              titleMenuGrid ?? "Top Up",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  spendingList() {
    return Card(
      elevation: 2,
      child: Container(
        padding:
            const EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 16),
        child: Column(
          children: [
            Row(
              children: [
                titleCard(),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    print("View All");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpendingListPage(),
                      ),
                    );
                  },
                  child: Text(
                    "View All",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return spendingTile();
              },
            ),
          ],
        ),
      ),
    );
  }

  Text titleCard({String? title}) {
    return Text(
      title ?? "Spending List",
      style: GoogleFonts.poppins(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  spendingTile() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      constraints: const BoxConstraints(minHeight: 64),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        onTap: () {
          print("Transfer");
        },
        subtitle: Text(
          "12 Jan 2021",
          style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color.fromARGB(255, 4, 110, 33)),
        ),
        title: Text(
          "Transfer",
          style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 5, 99, 9)),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Rp 50.000",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 49, 111, 51),
              ),
            ),
            Text(
              "Success",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 49, 111, 51),
              ),
            ),
          ],
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          radius: 24,
          child: Icon(
            Icons.account_balance_wallet,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
