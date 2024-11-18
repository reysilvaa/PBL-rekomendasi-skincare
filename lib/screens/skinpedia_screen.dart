import 'package:flutter/material.dart';

class SkinpediaScreen extends StatelessWidget {
  final List<Map<String, String>> articles = [
    {
      "title": "Jenis-Jenis Jerawat",
      "content": "Pelajari berbagai jenis jerawat seperti komedo, papula, pustula, dan lainnya, serta cara mengatasinya.",
      "image": "assets/skinpedia/jenis jerawat.jpg", // Tambahkan gambar terkait jerawat
    },
    {
      "title": "Makanan yang Harus Dihindari",
      "content": "Hindari makanan berminyak, tinggi gula, dan produk olahan untuk kulit yang lebih sehat.",
      "image": "assets/skinpedia/makanan.jpg", // Gambar terkait makanan
    },
    {
      "title": "Do's and Don'ts untuk Kulit Berjerawat",
      "content": "Pelajari kebiasaan yang membantu mencegah jerawat dan hindari kebiasaan yang memperburuknya.",
      "image": "assets/skinpedia/jerawat.jpg", // Gambar terkait do's and don'ts
    },
    {
      "title": "Manfaat Perawatan Rutin",
      "content": "Kenali pentingnya mencuci muka, melembapkan kulit, dan menggunakan sunscreen setiap hari.",
      "image": "assets/skinpedia/perawatan.jpg", // Gambar terkait perawatan rutin
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skinpedia"),
        backgroundColor: const Color(0xFF0046BE),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text(
                article["title"]!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                article["content"]!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(article["title"]!),
                    content: Row(
                      children: [
                        Expanded(
                          child: Text(
                            article["content"]!,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          article["image"]!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Tutup",
                          style: TextStyle(color: Color(0xFF0046BE)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
