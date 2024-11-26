import 'package:flutter/material.dart';
import '../../model/skinpedia.dart';

class SkinpediaCard extends StatelessWidget {
  final Skinpedia skinpedia;
  final VoidCallback onTap;

  const SkinpediaCard({
    Key? key,
    required this.skinpedia,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 6, // Elevation lebih tinggi untuk efek bayangan
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners lebih besar
        ),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Margin lebih besar untuk ruang yang lebih luas
        color: Colors.white, // Latar belakang putih untuk kontras lebih baik
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (skinpedia.image.isNotEmpty)
              Image.network(
                skinpedia.image,
                height: 180, // Ukuran gambar sedikit lebih besar
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, size: 70), // Ukuran ikon diperbesar
                  ),
                ),
              )
            else
              Container(
                height: 180,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.image_not_supported, size: 70),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0), // Padding lebih besar agar teks lebih nyaman dibaca
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    skinpedia.title,
                    style: const TextStyle(
                      fontSize: 20, // Ukuran font lebih besar
                      fontWeight: FontWeight.bold, // Menggunakan bold untuk judul
                      color: Colors.black87, // Warna teks lebih gelap untuk kontras yang lebih baik
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12), // Ruang lebih besar antar elemen
                  Text(
                    skinpedia.description,
                    style: TextStyle(
                      fontSize: 16, // Ukuran font sedikit lebih besar
                      color: Colors.grey[700],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
