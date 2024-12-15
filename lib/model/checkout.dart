import 'package:deteksi_jerawat/model/product.dart';

class Checkout {
  final int idCheckout;
  final int idUser;
  final int idHistory;
  final double totalHarga;
  final Product product;
  final DateTime createdAt;

  Checkout({
    required this.idCheckout,
    required this.idUser,
    required this.idHistory,
    required this.totalHarga,
    required this.product,
    required this.createdAt,
  });

  factory Checkout.fromJson(Map<String, dynamic> json) {
    return Checkout(
      idCheckout: json['id_checkout'],
      idUser: json['id_user'],
      idHistory: json['id_history'],
      totalHarga: (json['total_harga'] as num).toDouble(),
      product: Product.fromJson(json['product']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_checkout': idCheckout,
      'id_user': idUser,
      'id_history': idHistory,
      'total_harga': totalHarga,
      'product': product.toJson(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}