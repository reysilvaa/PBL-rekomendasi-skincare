import 'package:deteksi_jerawat/model/product.dart';

class Scan {
  final bool success;
  final Data data;

  Scan({required this.success, required this.data});

  // Factory method to create ScanResultModel from JSON
  factory Scan.fromJson(Map<String, dynamic> json) {
    return Scan(
      success: json['success'] ?? false,
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final History history;
  final SkinCondition condition;
  final List<Product> products;
  final Treatment treatment;
  final Prediction prediction;

  Data({
    required this.history,
    required this.condition,
    required this.products,
    required this.treatment,
    required this.prediction,
  });

  // Factory method to create Data from JSON
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      history: History.fromJson(json['history']),
      condition: SkinCondition.fromJson(json['condition']),
      products: List<Product>.from(json['products'] ?? []),
      treatment: Treatment.fromJson(json['treatment']),
      prediction: Prediction.fromJson(json['prediction']),
    );
  }
}

class History {
  final int historyId;
  final String gambarScan;
  final String detectionDate;
  final int recommendationId;

  History({
    required this.historyId,
    required this.gambarScan,
    required this.detectionDate,
    required this.recommendationId,
  });

  // Factory method to create History from JSON
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      historyId: json['history_id'] ?? 0,
      gambarScan: json['gambar_scan'] ?? '',
      detectionDate: json['detection_date'] ?? '',
      recommendationId: json['recommendation_id'] ?? 0,
    );
  }
}

class SkinCondition {
  final String conditionName;
  final String description;

  SkinCondition({
    required this.conditionName,
    required this.description,
  });

  // Factory method to create SkinCondition from JSON
  factory SkinCondition.fromJson(Map<String, dynamic> json) {
    return SkinCondition(
      conditionName: json['condition_name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Treatment {
  final String deskripsiTreatment;

  Treatment({required this.deskripsiTreatment});

  // Factory method to create Treatment from JSON
  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      deskripsiTreatment: json['deskripsi_treatment'] ?? '',
    );
  }
}

class Prediction {
  final int predictionClass;
  final double confidence;

  Prediction({required this.predictionClass, required this.confidence});

  // Factory method to create Prediction from JSON
  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      predictionClass: json['class'] ?? 0,
      confidence: json['confidence']?.toDouble() ?? 0.0,
    );
  }
}
