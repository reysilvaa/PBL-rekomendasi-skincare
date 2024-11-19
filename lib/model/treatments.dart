class Treatments {
  final int deskripsi_treatment;

  Treatments({
    required this.deskripsi_treatment,
  });

  factory Treatments.fromJson(Map<String, dynamic> json) {
    return Treatments(
      deskripsi_treatment: json['id_treatment'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_treatment': deskripsi_treatment,
    };
  }

  static Treatments empty() {
    return Treatments(deskripsi_treatment: 0);
  }
}
