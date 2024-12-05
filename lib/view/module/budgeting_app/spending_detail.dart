import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpendingDetailsPage extends StatelessWidget {
  SpendingDetailsPage({super.key, this.title, this.amount});

  String? title;
  String? amount;


  @override
  Widget build(BuildContext context) {
  final Map<String, String> args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spending Details'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? 'Data not found',
                  style: GoogleFonts.poppins(fontSize: 24),
                ),
                // underline
                underLine(),
                buttonBar(),
                // Table
                tableSection(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container underLine() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      height: 2,
      width: double.infinity,
      color: Colors.green,
    );
  }

  Table tableSection() {
    return Table(
      border: TableBorder.all(
        color: Colors.green,
        width: 2,
        borderRadius: BorderRadius.circular(8),
      ),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        tableHeader(),
        tableChildren(field: 'Amount', value: amount ?? 'Rp. 100.000'),
        tableChildren(field: 'Category', value: 'Food'),
        tableChildren(field: 'Date', value: '2021-10-10'),
      ],
    );
  }

  Row buttonBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {},
          child: const Icon(Icons.download),
        ),
        // share button
        OutlinedButton(
          onPressed: () {},
          child: const Icon(Icons.share),
        ),
        // delete button
        OutlinedButton(
          onPressed: () {},
          child: const Icon(Icons.delete),
        ),
        // edit button
        OutlinedButton(
          onPressed: () {},
          child: const Icon(Icons.edit),
        ),
      ],
    );
  }

  TableRow tableChildren({String? field, String? value}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(field ?? 'Amount'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value ?? 'Rp. 100.000'),
        ),
      ],
    );
  }

  TableRow tableHeader() {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Field',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Value',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
