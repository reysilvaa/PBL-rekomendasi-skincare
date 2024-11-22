class Product {
  final int productId;
  final String productName;
  final String description;
  final String productImage;
  final double price;
  final int stock;
  final int rating;
  final int conditionId; // Add conditionId field

  Product({
    required this.productId,
    required this.productName,
    required this.description,
    required this.productImage,
    required this.price,
    required this.stock,
    required this.rating,
    required this.conditionId, // Add conditionId to constructor
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'] != null
          ? json['product_id'] as int
          : 0, // Handle null values gracefully
      productName:
          json['product_name'] ?? '', // Default to empty string if null
      description: json['description'] ?? '', // Default to empty string if null
      productImage:
          json['product_image'] ?? '', // Default to empty string if null
      price: _safeParseDouble(json['price']),
      stock: json['stok'] != null
          ? json['stok'] as int
          : 0, // Handle null values gracefully
      rating: json['rating'] != null
          ? json['rating'] as int
          : 0, // Handle null values gracefully
      conditionId: json['condition_id'] != null
          ? json['condition_id'] as int
          : 0, // Handle null condition_id gracefully
    );
  }

  static double _safeParseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
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
      'condition_id': conditionId, // Include conditionId in toJson
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
      conditionId: 0, // Default value for conditionId
    );
  }
}
