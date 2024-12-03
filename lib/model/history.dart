import 'package:deteksi_jerawat/model/recommendation.dart';

class History {
  final int historyId;
  final int userId;
  final String gambarScan;
  final String gambarScanPredicted;
  final DateTime detectionDate;
  final int recommendationId;
  final Recommendation recommendation;

  History({
    required this.historyId,
    required this.userId,
    required this.gambarScan,
    required this.gambarScanPredicted,
    required this.detectionDate,
    required this.recommendationId,
    required this.recommendation,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      historyId: json['history_id'] as int,
      userId: json['user_id'] as int,
      gambarScan: json['gambar_scan'] as String,
      gambarScanPredicted: json['gambar_scan_predicted'] as String,
      detectionDate: DateTime.parse(json['detection_date']),
      recommendationId: json['recommendation_id'] as int,
      recommendation: Recommendation.fromJson(json['recommendation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'history_id': historyId,
      'user_id': userId,
      'gambar_scan': gambarScan,
      'gambar_scan_predicted': gambarScanPredicted,
      'detection_date': detectionDate.toIso8601String(),
      'recommendation_id': recommendationId,
      'recommendation': recommendation.toJson(),
    };
  }

  static History empty() {
    return History(
      historyId: 0,
      userId: 0,
      gambarScan: '',
      gambarScanPredicted: '',
      detectionDate: DateTime.now(),
      recommendationId: 0,
      recommendation: Recommendation.empty(),
    );
  }
}
