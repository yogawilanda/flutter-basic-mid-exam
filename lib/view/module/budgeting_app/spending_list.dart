import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';

class SpendingListPage extends StatefulWidget {
  const SpendingListPage({super.key});

  @override
  State<SpendingListPage> createState() => _SpendingListPageState();
}

class _SpendingListPageState extends State<SpendingListPage> {
  // manual data
  final List<Map<String, String>> _spendingListData = [
    {'title': 'Beli Makan Siang', 'amount': 'Rp. 15000'},
    {'title': 'Ongkos Transportasi', 'amount': 'Rp. 8000'},
    {'title': 'Kopi di Cafe', 'amount': 'Rp. 25000'},
    {'title': 'Beli Pulsa', 'amount': 'Rp. 50000'},
    {'title': 'Beli Buku', 'amount': 'Rp. 40000'},
    {'title': 'Belanja di Pasar', 'amount': 'Rp. 75000'},
    {'title': 'Tagihan Listrik', 'amount': 'Rp. 200000'},
    {'title': 'Bayar Kos', 'amount': 'Rp. 800000'},
    {'title': 'Beli Cemilan', 'amount': 'Rp. 10000'},
    {'title': 'Beli Pakaian', 'amount': 'Rp. 150000'},
    {'title': 'Beli Pakaian', 'amount': 'Rp. 150000'},
  ];

  List<Map<String, String>> get _spendingList => _spendingListData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spending List'),
      ),
      body: Column(
        children: [
          InfographSpendingList(spendingList: _spendingList),
          Expanded(
            child: ListViewSpendingList(spendingList: _spendingList),
          ),
        ],
      ),
    );
  }
}

// Helper function to format the currency
String formatCurrency(int amount) {
  if (amount >= 1000000) {
    return "${(amount / 1000000).toStringAsFixed(2)}MiO";
  } else if (amount >= 100000) {
    return "Rp. ${(amount / 100000).toStringAsFixed(2)}Hnr";
  } else if (amount >= 1000) {
    return "${(amount / 1000).toStringAsFixed(2)}K";
  } else {
    return "Rp. $amount";
  }
}

// Helper function to create a bar chart
Widget buildBarChart(List<Map<String, String>> spendingList) {
  Map<String, int> spendingData = {
    // sort the list by amount
    for (var item in spendingList
      ..sort((a, b) => int.parse(b['amount']!.substring(4))
          .compareTo(int.parse(a['amount']!.substring(4)))))
      item['title']!: int.parse(item['amount']!.substring(4)),
  };
  return Wrap(
    alignment: WrapAlignment.center,
    spacing: 8.0,
    runSpacing: 4.0,
    children: spendingData.entries.map((entry) {
      return Column(
        children: [
          Text(
            formatCurrency(entry.value),
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.green[800],
            ),
          ),
          Text(
            entry.key,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          Container(
            height: entry.value.toDouble() / 10000,
            width: 24,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      );
    }).toList(),
  );
}

class InfographSpendingList extends StatelessWidget {
  const InfographSpendingList({
    super.key,
    required List<Map<String, String>> spendingList,
  }) : _spendingList = spendingList;
  final List<Map<String, String>> _spendingList;
  @override
  Widget build(BuildContext context) {
    int totalSpending = _spendingList.fold<int>(
      0,
      (prev, element) => prev + int.parse(element['amount']!.substring(4)),
    );
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${_spendingList.length} Transaksi",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Total Spending:",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          Text(
            formatCurrency(totalSpending),
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green[900],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: buildBarChart(_spendingList),
            ),
          ),
        ],
      ),
    );
  }
}

class ListViewSpendingList extends StatelessWidget {
  const ListViewSpendingList({
    super.key,
    required List<Map<String, String>> spendingList,
  }) : _spendingList = spendingList;

  final List<Map<String, String>> _spendingList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _spendingList.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey[300],
      ),
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          leading: const CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.attach_money, color: Colors.white),
          ),
          title: Text(
            _spendingList[index]['title'] ?? 'No title',
            style: GoogleFonts.poppins(
              // color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            _spendingList[index]['amount'] ?? 'No amount',
            style: TextStyle(
                // color: Colors.white,
                ),
          ),
          trailing: Icon(Icons.chevron_right, color: Colors.green),
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.spendingDetailsPage,
              arguments: {
                'title': _spendingList[index]['title'] ?? 'No title',
                'amount': _spendingList[index]['amount'] ?? 'No amount',
              },
            );
          },
        );
      },
    );
  }
}
