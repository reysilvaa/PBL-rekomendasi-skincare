import 'product.dart';
import 'skincondition.dart';

class Recommendation {
  final int recommendationId;
  final int conditionId;
  final int productId;
  final SkinCondition? skinCondition; // Nullable
  final Product? product; // Nullable

  Recommendation({
    required this.recommendationId,
    required this.conditionId,
    required this.productId,
    this.skinCondition, // Nullable
    this.product, // Nullable
  });

  // Factory constructor for parsing from JSON
  factory Recommendation.fromJson(Map<String, dynamic> json) {
    // Debugging line to inspect the 'recommendation' field
    print('Parsing recommendation: ${json['recommendation_id']}');

    return Recommendation(
      recommendationId: json['recommendation_id'] ?? 0,
      conditionId: json['condition_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      skinCondition: json['skin_condition'] != null
          ? SkinCondition.fromJson(json['skin_condition'])
          : null, // Null safety: Check if 'skin_condition' exists and parse it
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : null, // Null safety: Check if 'product' exists and parse it
    );
  }

  // Method for converting to JSON
  Map<String, dynamic> toJson() {
    return {
      'recommendation_id': recommendationId,
      'condition_id': conditionId,
      'product_id': productId,
      'skin_condition':
          skinCondition?.toJson(), // Safe access for skinCondition
      'product': product?.toJson(), // Safe access for product
    };
  }

  // Method to return an empty Recommendation instance
  static Recommendation empty() {
    return Recommendation(
      recommendationId: 0,
      conditionId: 0,
      productId: 0,
      skinCondition: null,
      product: null,
    );
  }
}
