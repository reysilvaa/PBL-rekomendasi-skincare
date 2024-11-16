// lib/widgets/brand_list.dart
import 'package:deteksi_jerawat/model/brands.dart';
import 'package:flutter/material.dart';
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
          // Show a loading indicator while fetching data
          return const Center(child: CircularProgressIndicator());
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
            height: 100,
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
}
