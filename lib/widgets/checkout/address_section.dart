import 'package:deteksi_jerawat/blocs/address/address_bloc.dart';
import 'package:deteksi_jerawat/blocs/address/address_event.dart';
import 'package:deteksi_jerawat/blocs/address/address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AddressSection extends StatefulWidget {
  final String? initialAddress;
  final VoidCallback? onAddressChanged;

  const AddressSection({
    Key? key,
    this.initialAddress,
    this.onAddressChanged,
  }) : super(key: key);

  @override
  _AddressSectionState createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {
  final MapController _mapController = MapController();
  double _currentZoom = 13.0;

  @override
  void initState() {
    super.initState();
    context
        .read<AddressBloc>()
        .add(InitializeAddressEvent(initialAddress: widget.initialAddress));
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = _currentZoom < 18.0 ? _currentZoom + 1 : 18.0;
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = _currentZoom > 3.0 ? _currentZoom - 1 : 3.0;
    });
  }

  void _updateAddress(LatLng point) {
    context.read<AddressBloc>().add(UpdateAddressEvent(
        address: '' ??
            widget
                .initialAddress!, // We will get the address from the reverse geocode
        location: point,
        onChanged: widget.onAddressChanged));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state.status == AddressStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Error occurred')));
        }

        if (state.status == AddressStatus.success) {
          _mapController.move(state.location, _currentZoom);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            // Address Section (unchanged)
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
                        state.status == AddressStatus.loading
                            ? const LinearProgressIndicator(
                                backgroundColor: Colors.blue,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                state.address,
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
                    icon: const Icon(Icons.my_location,
                        color: Colors.blue, size: 30),
                    onPressed: () {
                      context
                          .read<AddressBloc>()
                          .add(FetchCurrentLocationEvent());

                      // Call onChanged after fetching the current location
                      if (widget.onAddressChanged != null) {
                        widget.onAddressChanged!();
                      }

                      // Optional: You can also directly trigger saving the address in the database here
                      final address = context.read<AddressBloc>().state.address;
                      if (address != null && widget.onAddressChanged != null) {
                        // Assuming you have the correct LatLng `location` from somewhere (e.g., the current location or tap on map)
                        LatLng location = state
                            .location; // Get the current location from state

                        // Now, call _updateAddress with the LatLng location, not the address
                        _updateAddress(
                            location); // Pass only the LatLng to _updateAddress
                      }
                    },
                    tooltip: 'Lokasi Saya',
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Map Section (with _updateAddress method)
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
                        center: state.location,
                        zoom: _currentZoom,
                        minZoom: 3.0,
                        maxZoom: 18.0,
                        onTap: (tapPosition, point) => _updateAddress(point),
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
                              point: state.location,
                              builder: (ctx) => Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue.withOpacity(0.3),
                                  border:
                                      Border.all(color: Colors.blue, width: 3),
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
      },
    );
  }
}
