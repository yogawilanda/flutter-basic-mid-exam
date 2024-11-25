import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_flutter/model/product.dart';
import 'package:hello_flutter/view/module/toko_module/customer_cart_page.dart';
import 'package:hello_flutter/view/module/toko_module/product_details_page.dart';

class CustomerShop extends StatefulWidget {
  const CustomerShop({super.key});
  @override
  State<CustomerShop> createState() => _CustomerShopState();
}

class _CustomerShopState extends State<CustomerShop> {
  List<Product> products = [
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
  List<Product> searchedProducts = [];
  TextEditingController searchController = TextEditingController();
  bool isGridView = false;

  // product added to cart
  List<Product> addedToCartProducts = [];

  @override
  void initState() {
    super.initState();
    searchedProducts = products;
  }

  void changeProductsList() {
    setState(() {
      isGridView = !isGridView;
    });
  }

  void sortProductsList() {
    setState(() {
      products = products.reversed.toList();
      searchedProducts = searchedProducts.reversed.toList();
    });
  }

  void searchProducts(String query) {
    List<Product> searchResults = [];
    if (query.isNotEmpty) {
      searchResults = products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      searchResults = products;
    }
    setState(() {
      searchedProducts = searchResults;
    });
  }

  Future<void> _openProductDetails(Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Shop'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleBody(),
              productViewChanger(),
              isGridView ? productGridView() : productListView(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerCartPage(listOfProductAddedToCart: addedToCartProducts),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart_rounded),
      ),
    );
  }

  titleBody() {
    return const Text(
      'Product List',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
      textAlign: TextAlign.left,
    );
  }

  productViewChanger() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Search Product',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              hintText: 'Search Product',
              hintStyle: const TextStyle(color: Colors.grey),
              labelStyle: const TextStyle(color: Colors.green),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.green),
              ),
              hoverColor: Colors.green,
            ),
            onChanged: (value) {
              searchProducts(value);
            },
            controller: searchController,
          ),
        ),
        IconButton(
          onPressed: changeProductsList,
          icon: Icon(
            isGridView ? Icons.list : Icons.grid_view,
            color: Colors.green,
            size: 30,
          ),
        ),
        IconButton(
          onPressed: sortProductsList,
          icon: Icon(
            isGridView ? Icons.sort : Icons.sort_rounded,
            color: Colors.green,
            size: 30,
          ),
        ),
      ],
    );
  }

  productGridView() {
    return searchedProducts.isEmpty && searchController.text.isNotEmpty
        ? Center(
            child: Text(
              'No Product Founds',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.green[600],
                  fontSize: 24,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: searchedProducts.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () => _openProductDetails(searchedProducts[index]),
                  child: GridTile(
                    header: GridTileBar(
                      title: Text(
                        searchedProducts[index].name,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    footer: GridTileBar(
                      title: Text(
                        'Rp. ${searchedProducts[index].price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: Colors.green,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.green,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  productListView() {
    return searchedProducts.isEmpty && searchController.text.isNotEmpty
        ? Center(
            child: Column(
              children: [
                const Icon(
                  Icons.search_off,
                  color: Colors.green,
                  size: 50,
                ),
                Text(
                  'No Product Founds',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.green[600],
                      fontSize: 24,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: searchedProducts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListTile(
                  leading: const Icon(Icons.shopping_cart, color: Colors.green),
                  title: Text(
                    searchedProducts[index].name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    'Rp. ${searchedProducts[index].price.toStringAsFixed(0)}',
                    style: const TextStyle(color: Colors.green, fontSize: 16),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      setState(() {
                        addedToCartProducts.add(searchedProducts[index]);
                      });

                      print(
                          'Product ${searchedProducts[index].name} added to cart');
                      // iterate each product in cart
                      print(
                          'List of products in cart: ${addedToCartProducts.map((product) => product.name).toList()}');
                      // print("list of products in cart: $addedToCartProducts");
                    },
                    child: CircleAvatar(
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  tileColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onTap: () {
                    debugPrint(
                      'Product ${searchedProducts[index].name} clicked',
                    );
                    _openProductDetails(searchedProducts[index]);
                  },
                ),
              );
            },
          );
  }
}
