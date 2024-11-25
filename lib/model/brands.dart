// lib/model/brand.dart
class Brand {
  final String productName;
  final int rating;

  Brand({required this.productName, required this.rating});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      productName: json['product_name'] ?? 'Unknown Brand', // Default if null
      rating: json['rating'] ?? 0, // Default if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_name': productName,
      'rating': rating,
    };
  }
}
