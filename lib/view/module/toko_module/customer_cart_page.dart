import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: const Text('Cart List'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          summaryList(totalAmout),
          titleListView(),
          productListView(),
        ],
      ),
    );
  }

  Container summaryList(double totalAmout) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        runSpacing: 20,
        spacing: 40,
        children: [
          Text(
            "Total product: ${widget.listOfProductAddedToCart.length}",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "Total Price: ${widget.listOfProductAddedToCart.fold(0.0, (previousValue, element) => previousValue + element.price).toInt()}",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Tax: $taxMultiplier%',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Total Amount: ${totalAmout + (totalAmout * taxMultiplier / 100).toInt()}',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Container titleListView() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(8),
      child: Text(
        "List of Product",
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  ListView productListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.listOfProductAddedToCart.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: ListTile(
            leading: CircleAvatar(child: Text((index + 1).toString())),
            style: ListTileStyle.list,
            textColor: Colors.white,
            contentPadding: const EdgeInsets.all(12),
            title: Text(
              widget.listOfProductAddedToCart[index].name,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            subtitle:
                Text(widget.listOfProductAddedToCart[index].price.toString()),
            onTap: () {
              setState(() {
                widget.listOfProductAddedToCart.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }
}
