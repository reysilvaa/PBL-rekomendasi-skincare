import 'package:deteksi_jerawat/model/product.dart';
import 'package:deteksi_jerawat/model/skincondition.dart';

class Recommendation {
  final int recommendationId;
  final int conditionId;
  final int productId;
  final SkinCondition skinCondition;
  final Product product;

  Recommendation({
    required this.recommendationId,
    required this.conditionId,
    required this.productId,
    required this.skinCondition,
    required this.product,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      recommendationId: json['recommendation_id'],
      conditionId: json['condition_id'],
      productId: json['product_id'],
      skinCondition: SkinCondition.fromJson(json['skin_condition']),
      product: Product.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recommendation_id': recommendationId,
      'condition_id': conditionId,
      'product_id': productId,
      'skin_condition': skinCondition.toJson(),
      'product': product.toJson(),
    };
  }
}
