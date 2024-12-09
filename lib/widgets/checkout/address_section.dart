import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'dart:convert';

class AddressSection extends StatefulWidget {
  const AddressSection({Key? key}) : super(key: key);

  @override
  _AddressSectionState createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {
  // State Variables
  String _address = "Pilih lokasi Anda";
  LatLng _selectedLocation = LatLng(-6.2088, 106.8456); // Default Jakarta
  bool _isLoading = false;

  // Map Controllers
  final MapController _mapController = MapController();
  double _currentZoom = 13.0;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    await _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      switch (permission) {
        case LocationPermission.always:
        case LocationPermission.whileInUse:
          await _getCurrentLocation();
          break;
        case LocationPermission.denied:
          _showLocationPermissionDialog();
          break;
        case LocationPermission.deniedForever:
          _showOpenSettingsDialog();
          break;
        default:
          _showErrorDialog("Status izin tidak dikenali");
      }
    } catch (e) {
      _showErrorDialog("Gagal memeriksa izin lokasi: $e");
    }
  }

  Future<void> _updateMapAndAddress(LatLng location) async {
    setState(() {
      _selectedLocation = location;
      _isLoading = true;
    });

    // Animate map to the new location
    _mapController.move(location, _currentZoom);

    // Fetch address for the new location
    await _fetchAddressFromCoordinates(location);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      LatLng currentLocation = LatLng(position.latitude, position.longitude);

      // Use the new method to update map and address
      await _updateMapAndAddress(currentLocation);
    } catch (e) {
      setState(() {
        _address = "Gagal mendapatkan lokasi: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchAddressFromCoordinates(LatLng location) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${location.latitude}&lon=${location.longitude}',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _address = data['display_name'] ?? "Alamat tidak ditemukan";
        });
      } else {
        setState(() {
          _address =
              "Gagal memuat alamat (Kode status: ${response.statusCode})";
        });
      }
    } catch (e) {
      setState(() {
        _address = "Terjadi kesalahan saat mengambil alamat: $e";
      });
    }
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = _currentZoom < 18.0 ? _currentZoom + 1 : 18.0;
      _mapController.move(_selectedLocation, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = _currentZoom > 3.0 ? _currentZoom - 1 : 3.0;
      _mapController.move(_selectedLocation, _currentZoom);
    });
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Izin Lokasi Diperlukan'),
        content: const Text(
            'Aplikasi membutuhkan izin lokasi untuk menampilkan peta dan alamat.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _checkLocationPermission();
            },
            child: const Text('Izinkan'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  void _showOpenSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Izin Lokasi Ditolak'),
        content: const Text(
            'Buka pengaturan aplikasi untuk mengaktifkan izin lokasi.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Address Section
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.blue, size: 30),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Alamat Pengiriman',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    _isLoading
                        ? const LinearProgressIndicator(
                            backgroundColor: Colors.blue,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            _address,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ],
                ),
              ),
              IconButton(
                icon:
                    const Icon(Icons.my_location, color: Colors.blue, size: 30),
                onPressed: _getCurrentLocation,
                tooltip: 'Lokasi Saya',
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Enhanced Map
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: _selectedLocation,
                    zoom: _currentZoom,
                    minZoom: 3.0,
                    maxZoom: 18.0,
                    onTap: (tapPosition, point) async {
                      // Use the new method to update map and address
                      await _updateMapAndAddress(point);
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
                      subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                      maxZoom: 18.0,
                      keepBuffer: 5,
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 60.0,
                          height: 60.0,
                          point: _selectedLocation,
                          builder: (ctx) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.withOpacity(0.3),
                              border: Border.all(color: Colors.blue, width: 3),
                            ),
                            child: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 35.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Zoom Buttons
            Positioned(
              bottom: 16,
              right: 16,
              child: Column(
                children: [
                  FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.white,
                    onPressed: _zoomIn,
                    child: const Icon(Icons.add, color: Colors.blue),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.white,
                    onPressed: _zoomOut,
                    child: const Icon(Icons.remove, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
