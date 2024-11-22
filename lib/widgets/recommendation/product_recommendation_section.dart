import 'package:deteksi_jerawat/screens/history/checkout_screen.dart';
import 'package:deteksi_jerawat/widgets/recommendation/buy_button.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../model/recommendation.dart';

class ProductRecommendationSection extends StatefulWidget {
  final Recommendation recommendation;
  final ValueChanged<int>? onProductChanged;

  const ProductRecommendationSection({
    super.key,
    required this.recommendation,
    this.onProductChanged,
  });

  @override
  ProductRecommendationSectionState createState() =>
      ProductRecommendationSectionState();
}

class ProductRecommendationSectionState
    extends State<ProductRecommendationSection> {
  int _currentProductIndex = 0;

  @override
  Widget build(BuildContext context) {
    final products = widget.recommendation.skinCondition.products;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.blueGrey.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.blueGrey.shade700,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Text(
                  'Rekomendasi Skincare',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey.shade900,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          // Product Carousel
          if (products.isNotEmpty)
            CarouselSlider.builder(
              itemCount: products.length,
              options: CarouselOptions(
                height: 460, // Tinggi ditambah untuk tombol
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentProductIndex = index;
                  });
                  if (widget.onProductChanged != null) {
                    widget.onProductChanged!(index);
                  }
                },
              ),
              itemBuilder: (context, index, realIndex) {
                final product = products[index];
                return _buildProductCard(product);
              },
            )
          else
            const Center(
              child: Text(
                'Tidak ada produk tersedia',
                style: TextStyle(color: Colors.grey),
              ),
            ),

          // Indicator
          if (products.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: products.map((product) {
                int index = products.indexOf(product);
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentProductIndex == index
                        ? Colors.blueGrey.shade700
                        : Colors.blueGrey.shade300,
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildProductCard(dynamic product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              product.productImage,
              height: 200, // Adjusted height to prevent overflow
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200, // Adjusted height to match the image
                  color: Colors.blueGrey.shade100,
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.blueGrey.shade300,
                      size: 50,
                    ),
                  ),
                );
              },
            ),
          ),

          // Product Details wrapped in Expanded to prevent overflow
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Star Rating
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        size: 20,
                        color: index < product.rating
                            ? Colors.amber
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Product Description
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey.shade600,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),

          // Buy Button now inside the column, after other content
          BuyButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutScreen(product: product),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
