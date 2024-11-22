class Product {
  final int productId;
  final String productName;
  final String description;
  final String productImage;
  final double price;
  final int stock;
  final int rating;

  Product({
    required this.productId,
    required this.productName,
    required this.description,
    required this.productImage,
    required this.price,
    required this.stock,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'] as int,
      productName: json['product_name'] as String,
      description: json['description'] as String,
      productImage: json['product_image'] as String,
      price: double.parse(json['price']),
      stock: json['stok'] as int,
      rating: json['rating'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'description': description,
      'product_image': productImage,
      'price': price.toString(),
      'stok': stock,
      'rating': rating,
    };
  }

  static Product empty() {
    return Product(
      productId: 0,
      productName: '',
      description: '',
      productImage: '',
      price: 0.0,
      stock: 0,
      rating: 0,
    );
  }
}
