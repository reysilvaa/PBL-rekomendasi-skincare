import 'package:deteksi_jerawat/model/recommendation.dart';

class History {
  final int historyId;
  final int userId;
  final String gambarScan;
  final DateTime detectionDate;
  final int recommendationId;
  final Recommendation recommendation;

  History({
    required this.historyId,
    required this.userId,
    required this.gambarScan,
    required this.detectionDate,
    required this.recommendationId,
    required this.recommendation,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      historyId: json['history_id'],
      userId: json['user_id'],
      gambarScan: json['gambar_scan'],
      detectionDate: DateTime.parse(json['detection_date']),
      recommendationId: json['recommendation_id'],
      recommendation: Recommendation.fromJson(json['recommendation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'history_id': historyId,
      'user_id': userId,
      'gambar_scan': gambarScan,
      'detection_date': detectionDate.toIso8601String(),
      'recommendation_id': recommendationId,
      'recommendation': recommendation.toJson(),
    };
  }
}
