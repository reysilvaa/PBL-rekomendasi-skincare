import 'package:deteksi_jerawat/model/recommendation.dart';

class History {
  final int historyId;
  final int userId;
  final String? gambarScan; // Nullable
  final DateTime detectionDate;
  final int recommendationId;
  final Recommendation? recommendation; // Nullable

  History({
    required this.historyId,
    required this.userId,
    this.gambarScan,
    required this.detectionDate,
    required this.recommendationId,
    this.recommendation, // Nullable
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      historyId: json['history_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      gambarScan: json['gambar_scan'],
      detectionDate: json['detection_date'] != null
          ? DateTime.tryParse(json['detection_date']) ?? DateTime.now()
          : DateTime.now(),
      recommendationId: json['recommendation_id'] ?? 0,
      recommendation: json['recommendation'] != null
          ? Recommendation.fromJson(json['recommendation'])
          : null, // Null safety
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'history_id': historyId,
      'user_id': userId,
      'gambar_scan': gambarScan,
      'detection_date': detectionDate.toIso8601String(),
      'recommendation_id': recommendationId,
      'recommendation': recommendation?.toJson(), // Safe access
    };
  }

  static History empty() {
    return History(
      historyId: 0,
      userId: 0,
      gambarScan: null,
      detectionDate: DateTime.now(),
      recommendationId: 0,
      recommendation: null,
    );
  }
}
