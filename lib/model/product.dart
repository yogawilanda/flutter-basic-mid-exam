class Product {
  final int? id;
  final String name;
  final double price;
  final String? image;
  final String? description;

  Product(
      {this.id,
      required this.name,
      required this.price,
      this.image,
      this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'].toDouble(),
    );
  }
}
