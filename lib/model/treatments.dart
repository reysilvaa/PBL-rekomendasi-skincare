class Treatments {
  final String deskripsi_treatment;

  Treatments({
    required this.deskripsi_treatment,
  });

  factory Treatments.fromJson(Map<String, dynamic> json) {
    return Treatments(
      deskripsi_treatment: json['deskripsi_treatment'] ?? "null",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deskripsi_treatment': deskripsi_treatment,
    };
  }

  static Treatments empty() {
    return Treatments(deskripsi_treatment: "null");
  }
}
