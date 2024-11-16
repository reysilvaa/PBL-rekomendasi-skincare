import 'package:deteksi_jerawat/model/brands.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package
import '../../services/brands-info.dart';

class BrandList extends StatefulWidget {
  const BrandList({super.key});

  @override
  _BrandListState createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  late Future<List<Brand>> _brandsFuture;

  @override
  void initState() {
    super.initState();
    _brandsFuture = BrandService().fetchBrands(); // Fetch the list of brands
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Brand>>(
      future: _brandsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show shimmer effect while fetching data
          return _buildShimmerLoading();
        } else if (snapshot.hasError) {
          // Show error message if there's an issue with fetching
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Show message if no brands are available
          return const Center(child: Text('No brands available'));
        } else {
          // Display the brands in a horizontal list
          final brands = snapshot.data!;
          return SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: brands.length,
              itemBuilder: (context, index) {
                final brand = brands[index];
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Center(
                    child: Text(
                      brand.productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  /// Build shimmer loading widget
  Widget _buildShimmerLoading() {
    return SizedBox(
      height: 120, // Matches the height of the brand list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6, // Show 6 shimmer items
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 80,
                    height: 12,
                    color: Colors.grey[200], // Placeholder for text
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 60,
                    height: 12,
                    color: Colors.grey[200], // Placeholder for smaller text
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
