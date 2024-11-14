class Product {
  final int productId;
  final String productName;
  final String description;
  final String productImage;
  final String price;
  final int stock;

  Product({
    required this.productId,
    required this.productName,
    required this.description,
    required this.productImage,
    required this.price,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      productName: json['product_name'],
      description: json['description'],
      productImage: json['product_image'],
      price: json['price'],
      stock: json['stok'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'description': description,
      'product_image': productImage,
      'price': price,
      'stok': stock,
    };
  }
}
