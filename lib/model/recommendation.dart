import 'package:deteksi_jerawat/model/skincondition.dart';

class Recommendation {
  final int recommendationId;
  final int conditionId;
  final SkinCondition skinCondition;
  final SkinCondition condition;

  Recommendation({
    required this.recommendationId,
    required this.conditionId,
    required this.skinCondition,
    required this.condition,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      recommendationId: json['recommendation_id'] as int,
      conditionId: json['condition_id'] as int,
      skinCondition: SkinCondition.fromJson(json['skin_condition']),
      condition: SkinCondition.fromJson(json['condition']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recommendation_id': recommendationId,
      'condition_id': conditionId,
      'skin_condition': skinCondition.toJson(),
      'condition': condition.toJson(),
    };
  }

  static Recommendation empty() {
    return Recommendation(
      recommendationId: 0,
      conditionId: 0,
      skinCondition: SkinCondition.empty(),
      condition: SkinCondition.empty(),
    );
  }
}
