import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_mortgage_app/model/product.dart';
import 'package:user_mortgage_app/view/module/toko_module/transaction_page/customer_cart_page.dart';
import 'package:user_mortgage_app/view/module/toko_module/transaction_page/product_details_page.dart';

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
    Product(
      id: 7,
      name: 'Product 7',
      price: 700.0,
    ),
    Product(
      id: 8,
      name: 'Product 8',
      price: 700.0,
    ),
    Product(
      id: 9,
      name: 'Product 9',
      price: 700.0,
    ),
    Product(
      id: 10,
      name: 'Product 10',
      price: 700.0,
    ),
    Product(
      id: 11,
      name: 'Product 11',
      price: 700.0,
    ),
  ];
  List<Product> searchedProducts = [];
  TextEditingController searchController = TextEditingController();
  bool isGridView = false;

  // product added to cart
  List<Product> addedToCartProducts = [];

  // method to make custom addition on products
  bool showBottomSheet = false;
  int _itemCount = 0;

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Customer Shop'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // titleBody(),
            Container(
              margin: const EdgeInsets.all(8),
              child: productViewChanger(),
              decoration: BoxDecoration(
                // shadow
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: isGridView ? productGridView() : productListView(),
              ),
            ),
            Container(
              height: 50,
              color: Colors.green,
            ),
          ],
        ),
        floatingActionButton: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerCartPage(
                        listOfProductAddedToCart:
                            addedToCartProducts, // Make sure this is defined
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.shopping_cart_rounded),
              ),
            ),
            if (_itemCount > 0)
              Positioned(
                right: 0, // Position relative to the FAB
                top: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 15,
                  child: Text(
                    _itemCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ));
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
    return Container(
      color: Colors.white,
      child: Row(
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
      ),
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

  void _toggleBottomSheet() {
    setState(() {
      showBottomSheet = !showBottomSheet;
    });
  }

  void _changeItemCount() {
    setState(() {
      _itemCount++;
    });
  }

  void _decrementCount() {
    setState(() {
      if (_itemCount > 0) {
        _itemCount--;
      }
    });
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
                        // check if product is already in cart
                        if (addedToCartProducts
                            .contains(searchedProducts[index])) {
                          // remove product from cart
                          addedToCartProducts.remove(searchedProducts[index]);
                          _decrementCount();
                        } else {
                          // add product to cart
                          addedToCartProducts.add(searchedProducts[index]);
                          _changeItemCount();
                        }

                        // addedToCartProducts.add(searchedProducts[index]);
                        // _changeItemCount();
                      });

                      print(
                          'Product ${searchedProducts[index].name} added to cart');
                      // iterate each product in cart
                      print(
                          'List of products in cart: ${addedToCartProducts.map((product) => product.name).toList()}');
                      // print("list of products in cart: $addedToCartProducts");
                    },
                    child: addedToCartProducts.contains(searchedProducts[index])
                        ? const CircleAvatar(
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          )
                        : const CircleAvatar(
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

class _BottomSheetContent extends StatelessWidget {
  final int itemCount;
  final VoidCallback onClose;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _BottomSheetContent({
    required this.itemCount,
    required this.onClose,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,

        // border line black
        border: Border(
          top: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Items in Cart: $itemCount',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  onPressed: onDecrement, icon: const Icon(Icons.remove)),
              Text(itemCount.toString()),
              IconButton(onPressed: onIncrement, icon: const Icon(Icons.add)),
            ],
          ),
          ElevatedButton(
            onPressed: onClose, // Close the bottom sheet
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
