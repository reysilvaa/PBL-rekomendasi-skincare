import 'package:flutter/material.dart';
import 'package:deteksi_jerawat/model/scan.dart';
import 'package:http/http.dart' as http;

class ScanImagesSection extends StatefulWidget {
  final Scan scan;

  const ScanImagesSection({super.key, required this.scan});

  @override
  State<ScanImagesSection> createState() => _ScanImagesSectionState();
}

class _ScanImagesSectionState extends State<ScanImagesSection> {
  bool _showPredicted = false;

  Future<bool> _checkImageAvailable(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Widget _buildImage(String imageUrl, {bool isPredicted = false}) {
    return FutureBuilder<bool>(
      future: _checkImageAvailable(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        } else if (snapshot.hasError || !snapshot.data!) {
          return _buildErrorState();
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: GestureDetector(
              onTap: () {
                // Handle image tap if needed
              },
              child: Image.network(
                imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildLoadingState(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingState({double? value}) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: CircularProgressIndicator(
          value: value,
          color: Colors.blue[300],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.error_outline, color: Colors.red, size: 40),
          SizedBox(height: 8),
          Text(
            'Failed to load image',
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextButton.icon(
        onPressed: () {
          setState(() {
            _showPredicted = !_showPredicted;
          });
        },
        icon: Icon(
          _showPredicted ? Icons.visibility_off : Icons.visibility,
          color: Colors.blue[700],
        ),
        label: Text(
          _showPredicted ? 'Hide Prediction' : 'Show Prediction',
          style: TextStyle(
            color: Colors.blue[700],
            fontWeight: FontWeight.w600,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue[50],
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Hasil Scan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildImage(widget.scan.data.history.gambarScan),
          _buildToggleButton(),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: [
                _buildImage(
                  widget.scan.data.history.gambarScanPredicted,
                  isPredicted: true,
                ),
              ],
            ),
            crossFadeState: _showPredicted
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
