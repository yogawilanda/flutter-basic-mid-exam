import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            const BalanceChart(),
          ],
        ),
      ),
    );
  }
}

class BalanceDetails extends StatelessWidget {
  final int balanceToCard;

  BalanceDetails({required this.balanceToCard});

  String formattedValueBalance = convertBalanceToIDRCurrency(10000300);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = balanceToCard.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rp. ${formattedValueBalance}",
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
        const BalanceInfoRow(
          circleText: "Spent",
          title: "Rp 300.000",
          circleColor: Colors.orange,
        ),
        const BalanceInfoRow(
          circleText: "Income",
          title: "Rp 1.000.000",
          circleColor: Colors.green,
        ),
      ],
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(radius: 6, backgroundColor: circleColor),
            const SizedBox(width: 4),
            Text(
              circleText,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black45,
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

class BalanceChart extends StatelessWidget {
  const BalanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: MediaQuery.of(context).size.width * 0.15,
      backgroundColor: Colors.green,
      child: const Icon(
        Icons.account_balance_wallet,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}

String convertBalanceToIDRCurrency(int balance) {
  return balance.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      );
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
        const CircleAvatar(
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
