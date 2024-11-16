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

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      recommendationId: json['recommendation_id'] ?? 0,
      conditionId: json['condition_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      skinCondition: json['skin_condition'] != null
          ? SkinCondition.fromJson(json['skin_condition'])
          : null, // Null safety
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : null, // Null safety
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recommendation_id': recommendationId,
      'condition_id': conditionId,
      'product_id': productId,
      'skin_condition': skinCondition?.toJson(), // Safe access
      'product': product?.toJson(), // Safe access
    };
  }

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
