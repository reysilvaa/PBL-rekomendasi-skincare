import 'package:flutter/material.dart';
import '../../model/skinpedia.dart';

class SkinpediaCard extends StatelessWidget {
  final Skinpedia skinpedia;
  final VoidCallback onTap;

  const SkinpediaCard({
    super.key,
    required this.skinpedia,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Define responsive font sizes
          double titleFontSize = constraints.maxWidth * 0.05;
          double descriptionFontSize = constraints.maxWidth * 0.035;

          return Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                Ink.image(
                  image: skinpedia.image.isNotEmpty
                      ? NetworkImage(skinpedia.image)
                      : const AssetImage('assets/skinpedia/jerawat.jpg')
                          as ImageProvider,
                  height: constraints.maxWidth * 0.6, // Responsive height
                  width: double.infinity,
                  fit: BoxFit.cover,
                  child: InkWell(onTap: onTap),
                ),
                // Text Section
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        skinpedia.title,
                        style: TextStyle(
                          fontSize: titleFontSize, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      // Description
                      Text(
                        skinpedia.description,
                        style: TextStyle(
                          fontSize: descriptionFontSize,
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
          );
        },
      ),
    );
  }
}
