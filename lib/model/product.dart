class Product {
  final int productId;
  final String productName;
  final String description;
  final String productImage;
  final String price;
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
      productId: json['product_id'] ?? 0, // Default to 0 if null
      productName: json['product_name'] ??
          'Unknown Product', // Default to a string if null
      description: json['description'] ??
          'No description available', // Default to a string if null
      productImage:
          json['product_image'] ?? '', // Default to an empty string if null
      price: json['price'] != null ? json['price'] : 0, // Default to 0 if null
      stock: json['stok'] != null ? json['stok'] : 0, // Default to 0 if null
      rating: json['rating'] != null
          ? json['rating'].toInt()
          : 0, // Default to 0 if null
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
      'rating': rating,
    };
  }
}
