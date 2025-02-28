import 'package:flutter/material.dart';

class TransactionDetailsPage extends StatelessWidget {
  int value = 2000;
  TransactionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatus(context),
                const SizedBox(height: 12),
                _buildTransactionDetail(context),
                const SizedBox(height: 12),
                _buildPaymentDetail(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.green,
          size: 60,
        ),
        Text(
          'Transaction Created',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildTransactionDetail(BuildContext context) {
    return _buildDetailContainer(
      context,
      children: [
        _buildDetailRow(context, 'Transaction ID', '12312'),
        const SizedBox(height: 12),
        _buildDetailRow(context, 'Payment Method', 'Cash'),
        const SizedBox(height: 12),
        _buildDetailRow(context, 'Created By', '-'),
        const SizedBox(height: 12),
        _buildDetailRow(context, 'Created At', '-'),
        const SizedBox(height: 12),
        _buildDetailRow(context, 'Customer Name', '-'),
        const SizedBox(height: 12),
        _buildDetailRow(context, 'Description', '-'),
      ],
    );
  }

  Widget _buildPaymentDetail(BuildContext context) {
    return _buildDetailContainer(
      context,
      children: [
        _buildDetailRow(context, 'Ordered Products', '0', isBold: true),
        const Divider(height: 24),
        ...List.generate(0, (i) => _buildProductDetail(context)),
        const Divider(height: 24),
        _buildDetailRow(context, 'Total', 'Rp. $value', isBold: true),
        const SizedBox(height: 12),
        _buildDetailRow(context, 'Payment Received', 'Rp. 0'),
        const SizedBox(height: 12),
        _buildDetailRow(context, 'Change', 'Rp. 0'),
      ],
    );
  }

  Widget _buildDetailContainer(BuildContext context,
      {required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value,
      {bool isBold = false, bool isUsingChip = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isBold
              ? Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold)
              : Theme.of(context).textTheme.bodyMedium,
        ),
        isUsingChip
            ? Chip(
              label: Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 12), // Smaller text
              ),
              backgroundColor: Colors.green[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            )
            : Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
      ],
    );
  }

  Widget _buildProductDetail(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
