class Item {
  int id;
  int business_id;
  String product_name;
  int product_price;
  Enum product_category;
  String product_description;
  String product_image;
  String product_sku;
  DateTime created_at;
  DateTime updated_at;

  Item({
    required this.id,
    required this.business_id,
    required this.product_name,
    required this.product_price,
    required this.product_category,
    required this.product_description,
    required this.product_image,
    required this.product_sku,
    required this.created_at,
    required this.updated_at,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      business_id: json['business_id'],
      product_name: json['product_name'],
      product_price: json['product_price'],
      product_category: json['product_category'],
      product_description: json['product_description'],
      product_image: json['product_image'],
      product_sku: json['product_sku'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': business_id,
      'product_name': product_name,
      'product_price': product_price,
      'product_category': product_category,
      'product_description': product_description,
      'product_image': product_image,
      'product_sku': product_sku,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'business_id': business_id,
      'product_name': product_name,
      'product_price': product_price,
      'product_category': product_category,
      'product_description': product_description,
      'product_image': product_image,
      'product_sku': product_sku,
      'created_at': created_at.toString(),
      'updated_at': updated_at.toString(),
    };
  }
}
