class Skinpedia {
  final int id;
  final String title;
  final String description;
  final String image;

  Skinpedia({required this.id, required this.title, required this.description, required this.image});

  factory Skinpedia.fromJson(Map<String, dynamic> json) {
    return Skinpedia(
      id: json['id_skinpedia'],
      title: json['judul'],
      description: json['deskripsi'],
      image: json['gambar'] ?? '',
    );
  }
}
