class SkinCondition {
  final int conditionId;
  final String conditionName;
  final String description;

  SkinCondition({
    required this.conditionId,
    required this.conditionName,
    required this.description,
  });

  factory SkinCondition.fromJson(Map<String, dynamic> json) {
    return SkinCondition(
      conditionId: json['condition_id'],
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
}
