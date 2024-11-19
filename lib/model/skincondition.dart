import 'package:deteksi_jerawat/model/treatments.dart';

class SkinCondition {
  final int conditionId;
  final String? conditionName; // Nullable
  final String? description; // Nullable
  final Treatments? deskripsi_treatment; // Nullable

  SkinCondition({
    required this.conditionId,
    this.conditionName,
    this.description,
    this.deskripsi_treatment,
  });

  factory SkinCondition.fromJson(Map<String, dynamic> json) {
    return SkinCondition(
      conditionId: json['condition_id'] ?? 0,
      conditionName: json['condition_name'],
      description: json['description'],
      deskripsi_treatment: json['id_treatment'], // diganti nkok
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'condition_id': conditionId,
      'condition_name': conditionName,
      'description': description,
      'id_treatments': deskripsi_treatment,
    };
  }

  static SkinCondition empty() {
    return SkinCondition(
      conditionId: 0,
      conditionName: null,
      description: null,
      deskripsi_treatment: null,
    );
  }
}
