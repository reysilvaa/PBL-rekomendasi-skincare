// lib/model/brand.dart
class Brand {
  final String productName;

  Brand({required this.productName});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      productName: json['product_name'] ?? 'Unknown Brand', // Default if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_name': productName,
    };
  }
}
