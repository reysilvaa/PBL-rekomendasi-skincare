import 'package:bloc/bloc.dart';
import 'package:deteksi_jerawat/blocs/address/address_event.dart';
import 'package:deteksi_jerawat/blocs/address/address_state.dart';
import 'package:deteksi_jerawat/services/config.dart';
import 'package:deteksi_jerawat/services/user-info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'dart:convert';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final http.Client httpClient;
  final UserInfoService _userInfoService;

  AddressBloc({
    http.Client? httpClient,
    UserInfoService? userInfoService,
  })  : httpClient = httpClient ?? http.Client(),
        _userInfoService = userInfoService ?? UserInfoService(),
        super(AddressState()) {
    on<InitializeAddressEvent>(_onInitializeAddress);
    on<UpdateAddressEvent>(_onUpdateAddress);
    on<FetchCurrentLocationEvent>(_onFetchCurrentLocation);
  }

  Future<void> _onInitializeAddress(
      InitializeAddressEvent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: AddressStatus.loading));

    try {
      // Try to fetch user's current address from profile
      final userInfo = await _userInfoService.fetchUserInfo();
      if (userInfo.address != null && userInfo.address!.isNotEmpty) {
        emit(state.copyWith(
            address: userInfo.address, status: AddressStatus.success));
        return;
      }

      // Fallback to previous initialization logic
      if (event.initialAddress != null && event.initialAddress!.isNotEmpty) {
        final location = await _geocodeAddress(event.initialAddress!);
        emit(state.copyWith(
            address: event.initialAddress,
            location: location,
            status: AddressStatus.success));
        return;
      }

      if (event.initialLocation != null) {
        final address = await _reverseGeocodeLocation(event.initialLocation!);
        emit(state.copyWith(
            address: address,
            location: event.initialLocation,
            status: AddressStatus.success));
        return;
      }

      // Default case: try current location
      await _getCurrentLocation(emit);
    } catch (e) {
      emit(state.copyWith(
          status: AddressStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateAddress(
      UpdateAddressEvent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: AddressStatus.loading));

    try {
      // If no address is provided, reverse geocode the location
      String updatedAddress = event.address.isEmpty
          ? await _reverseGeocodeLocation(event.location)
          : event.address;

      // Use UserInfoService to update address (if necessary)
      final updatedUser = await _userInfoService.updateAddress(updatedAddress);

      emit(state.copyWith(
          address: updatedUser.address,
          location: event.location,
          status: AddressStatus.success));

      // Call onChanged callback if provided
      event.onChanged?.call();
    } catch (e) {
      emit(state.copyWith(
          status: AddressStatus.error, errorMessage: e.toString()));
    }
  }

Future<void> _onFetchCurrentLocation(
    FetchCurrentLocationEvent event, Emitter<AddressState> emit) async {
  await _getCurrentLocation(emit);

  // Save the address after fetching the current location
  try {
    final address = state.address;
    if (address != null) {
      await _userInfoService.updateAddress(address); // Save the address to the database
      emit(state.copyWith(status: AddressStatus.success)); // Update the state
    }
  } catch (e) {
    emit(state.copyWith(
        status: AddressStatus.error, errorMessage: 'Failed to save address: $e'));
  }
}

  Future<void> _getCurrentLocation(Emitter<AddressState> emit) async {
    emit(state.copyWith(status: AddressStatus.loading));

    try {
      // Use Geolocator to get current location
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      final currentLocation = LatLng(position.latitude, position.longitude);
      final address = await _reverseGeocodeLocation(currentLocation);

      emit(state.copyWith(
          address: address,
          location: currentLocation,
          status: AddressStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: AddressStatus.error,
          errorMessage: 'Gagal mendapatkan lokasi: $e'));
    }
  }

  Future<LatLng> _geocodeAddress(String address) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?format=jsonv2&q=${Uri.encodeComponent(address)}',
    );

    try {
      final response = await httpClient.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final firstResult = data[0];
          return LatLng(double.parse(firstResult['lat']),
              double.parse(firstResult['lon']));
        }
        throw Exception('No location found');
      }
      throw Exception('Geocoding failed');
    } catch (e) {
      throw Exception('Error geocoding address: $e');
    }
  }

  Future<String> _reverseGeocodeLocation(LatLng location) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${location.latitude}&lon=${location.longitude}',
    );

    try {
      final response = await httpClient.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['display_name'] ?? "Alamat tidak ditemukan";
      }
      throw Exception('Reverse geocoding failed');
    } catch (e) {
      throw Exception('Error reverse geocoding: $e');
    }
  }
}
