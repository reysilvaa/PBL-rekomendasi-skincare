import 'package:deteksi_jerawat/model/product.dart';
import 'package:deteksi_jerawat/model/treatments.dart';

class SkinCondition {
  final int conditionId;
  final String conditionName;
  final String description;
  final Treatments treatments;
  final List<Product> products;

  SkinCondition({
    required this.conditionId,
    required this.conditionName,
    required this.description,
    required this.treatments,
    required this.products,
  });

  factory SkinCondition.fromJson(Map<String, dynamic> json) {
    return SkinCondition(
      conditionId: json['condition_id'] as int,
      conditionName: json['condition_name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      treatments: json['treatments'] != null
          ? Treatments.fromJson(json['treatments'])
          : Treatments.empty(),
      products: json['products'] != null
          ? (json['products'] as List)
              .map((productJson) => Product.fromJson(productJson))
              .toList()
          : [], // Tambahkan list kosong jika null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'condition_id': conditionId,
      'condition_name': conditionName,
      'description': description,
      'treatments': treatments.toJson(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

  static SkinCondition empty() {
    return SkinCondition(
      conditionId: 0,
      conditionName: '',
      description: '',
      treatments: Treatments.empty(),
      products: [],
    );
  }
}
