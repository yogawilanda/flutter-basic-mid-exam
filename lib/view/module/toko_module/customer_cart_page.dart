import 'package:flutter/material.dart';
import 'package:hello_flutter/model/product.dart';

class CustomerCartPage extends StatefulWidget {
  const CustomerCartPage({super.key, required this.listOfProductAddedToCart});

  final List<Product> listOfProductAddedToCart;

  @override
  State<CustomerCartPage> createState() => _CustomerCartPageState();
}

class _CustomerCartPageState extends State<CustomerCartPage> {
  int taxMultiplier = 10;

  @override
  Widget build(BuildContext context) {
    double totalAmout = widget.listOfProductAddedToCart
        .fold(0.0, (previousValue, element) => previousValue + element.price);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart List'),
      ),
      body: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            runSpacing: 20,
            spacing: 20,
            children: [
              Text("Total product: ${widget.listOfProductAddedToCart.length}"),
              Text(
                  "Total Price: ${widget.listOfProductAddedToCart.fold(0.0, (previousValue, element) => previousValue + element.price)}"),
              Text('Tax: $taxMultiplier%'),
              Text(
                  'Total Amount: ${totalAmout + (totalAmout * taxMultiplier / 100)}'),
            ],
          ),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.listOfProductAddedToCart.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text((index + 1).toString())),
                  title: Text(widget.listOfProductAddedToCart[index].name),
                  subtitle: Text(
                      widget.listOfProductAddedToCart[index].price.toString()),
                  onTap: () {
                    setState(() {
                      widget.listOfProductAddedToCart.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
