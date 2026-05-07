class Treatments {
  final String deskripsiTreatment;

  Treatments({
    required this.deskripsiTreatment,
  });

  factory Treatments.fromJson(Map<String, dynamic> json) {
    return Treatments(
      deskripsiTreatment: json['deskripsiTreatment'] ?? "null",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deskripsiTreatment': deskripsiTreatment,
    };
  }

  static Treatments empty() {
    return Treatments(deskripsiTreatment: "null");
  }
}
