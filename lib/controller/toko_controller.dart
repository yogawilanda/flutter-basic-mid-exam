import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/model/product.dart';

class TokoController extends ChangeNotifier {
  List<Product> searchedProducts = [];
  bool isGridView = false;

  List<Product> localProductsExample = [
    Product(
      id: 1,
      name: 'Product 1',
      price: 100.0,
      // picsum image
      image: 'https://loremflickr.com/320/240',
      description:
          'Introducing Product 1, the ultimate solution for your daily needs. Crafted with precision and care, this product boasts top-quality materials that ensure durability and long-lasting performance. Designed to cater to a wide range of uses, it seamlessly blends functionality and style. Whether you\'re at home, in the office, or on the go, Product 1 is your reliable companion. Its sleek design and user-friendly features make it an essential addition to your toolkit. Experience the perfect balance of innovation and convenience with Product 1, where quality meets excellence. Elevate your everyday routine with this exceptional product.',
    ),
    Product(
      id: 2,
      name: 'Product 2',
      price: 200.0,
    ),
    Product(
      id: 3,
      name: 'Product 3',
      price: 300.0,
    ),
    Product(
      id: 4,
      name: 'Product 4',
      price: 400.0,
    ),
    Product(
      id: 5,
      name: 'Product 5',
      price: 500.0,
    ),
    Product(
      id: 6,
      name: 'Product 6',
      price: 600.0,
    ),
  ];

  void changeProductView(bool isGridView) {
    isGridView = !isGridView;
  }

  void filterProducts(String query) {
    searchedProducts = localProductsExample.where((element) {
      return element.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void sortProductList() {
    localProductsExample = localProductsExample.reversed.toList();
    searchedProducts = searchedProducts.reversed.toList();
    notifyListeners();
  }
}
