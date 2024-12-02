import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/model/product.dart';
import 'package:google_fonts/google_fonts.dart';


class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isImageExist = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details ${widget.product.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageView(),
            titleWidget(),
            priceWidget(),
            descriptionView(),
          ],
        ),
      ),
    );
  }

  Text priceWidget() {
    return Text(
      'Rp. ${widget.product.price.toStringAsFixed(0)}',
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: Colors.green[800],
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Container titleWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Text(
        '${widget.product.name}',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.green,
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  imageView() {
    return Container(
      child: widget.product.image != null
          ? Container(
              constraints: BoxConstraints.expand(height: 400),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.product.image!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(
              constraints: BoxConstraints.expand(height: 400),
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: const Icon(
                Icons.image_not_supported,
                size: 100,
                color: Colors.white,
              ),
            ),
    );
  }

  descriptionView() {
    return Container(
      child: widget.product.description != null
          ? Text(
              '${widget.product.description}',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          : Text(
              'No Description',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
    );
  }
}
