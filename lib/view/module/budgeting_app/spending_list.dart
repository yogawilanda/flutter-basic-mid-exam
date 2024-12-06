import 'package:flutter/material.dart';

class SpendingListPage extends StatefulWidget {
  const SpendingListPage({super.key});

  @override
  State<SpendingListPage> createState() => _SpendingListPageState();
}

class _SpendingListPageState extends State<SpendingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spending List'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Spending $index'),
            subtitle: Text('Rp. ${index == 0 ? 5000 : index * 10000}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, '/spendingDetailsPage', arguments: {
                'title': 'Spending $index',
                'amount': 'Rp. ${index == 0 ? 5000 : index * 10000}'
              });
            },
          );
        },
      ),
    );
  }
}
