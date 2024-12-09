import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpendingDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String title = arguments?['title'] ?? 'Data not found';
    final String amount = arguments?['amount'] ?? 'Rp. 100.000';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spending Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            _buttonBar(),
            const SizedBox(height: 16),
            _detailsTable(amount),
          ],
        ),
      ),
    );
  }

  Widget _buttonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _customButton(icon: Icons.download, onPressed: () {}),
        _customButton(icon: Icons.share, onPressed: () {}),
        _customButton(icon: Icons.delete, onPressed: () {}),
        _customButton(icon: Icons.edit, onPressed: () {}),
      ],
    );
  }

  Widget _customButton({required IconData icon, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: const CircleBorder(),
          side: BorderSide(color: Colors.green),
        ),
        onPressed: onPressed,
        child: Icon(icon, color: Colors.green),
      ),
    );
  }

  Widget _detailsTable(String amount) {
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
        _tableHeader(),
        _tableRow(field: 'Amount', value: amount),
        _tableRow(field: 'Category', value: 'Food'),
        _tableRow(field: 'Date', value: '2021-10-10'),
      ],
    );
  }

  TableRow _tableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.green),
      children: [
        _tableCell('Field', isHeader: true),
        _tableCell('Value', isHeader: true),
      ],
    );
  }

  TableRow _tableRow({required String field, required String value}) {
    return TableRow(
      children: [
        _tableCell(field),
        _tableCell(value),
      ],
    );
  }

  Widget _tableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
