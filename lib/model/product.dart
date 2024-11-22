import 'package:deteksi_jerawat/model/skincondition.dart';

class Product {
  final int productId;
  final String? productName; // Nullable
  final String? description; // Nullable
  final String? productImage; // Nullable
  final String? price; // Nullable
  final int? stock; // Nullable
  final int? rating; // Nullable
  final SkinCondition? condition; // Nullable

  Product({
    required this.productId,
    this.productName,
    this.description,
    this.productImage,
    this.price,
    this.stock,
    this.rating,
    this.condition,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'] ?? 0,
      productName: json['product_name'],
      description: json['description'],
      productImage: json['product_image'],
      price: json['price']?.toString(),
      stock: json['stok'],
      rating:
          (json['rating'] is int) ? json['rating'] : (json['rating']?.toInt()),
      condition: json['id_condition'],
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
      'id_condition': condition,
    };
  }

  static Product empty() {
    return Product(
      productId: 0,
      productName: null,
      description: null,
      productImage: null,
      price: null,
      stock: null,
      rating: null,
      condition: null,
    );
  }
}
