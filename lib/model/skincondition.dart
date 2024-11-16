class SkinCondition {
  final int conditionId;
  final String? conditionName; // Nullable
  final String? description; // Nullable

  SkinCondition({
    required this.conditionId,
    this.conditionName,
    this.description,
  });

  factory SkinCondition.fromJson(Map<String, dynamic> json) {
    return SkinCondition(
      conditionId: json['condition_id'] ?? 0,
      conditionName: json['condition_name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'condition_id': conditionId,
      'condition_name': conditionName,
      'description': description,
    };
  }

  static SkinCondition empty() {
    return SkinCondition(
      conditionId: 0,
      conditionName: null,
      description: null,
    );
  }
}
