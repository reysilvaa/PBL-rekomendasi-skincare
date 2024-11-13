class Product {
  final int productId;
  final String productName;
  final String description;
  final String productImage;
  final double price;
  final int stok;

  Product({
    required this.productId,
    required this.productName,
    required this.description,
    required this.productImage,
    required this.price,
    required this.stok,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      productName: json['product_name'],
      description: json['description'],
      productImage: json['product_image'],
      price: json['price'].toDouble(),
      stok: json['stok'],
    );
  }
}
