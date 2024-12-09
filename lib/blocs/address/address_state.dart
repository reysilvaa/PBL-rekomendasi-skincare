import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

enum AddressStatus { initial, loading, success, error }

class AddressState extends Equatable {
  final String address;
  final LatLng location;
  final AddressStatus status;
  final String? errorMessage;

  const AddressState._({
    required this.address,
    required this.location,
    required this.status,
    this.errorMessage,
  });

  factory AddressState({
    String address = "Pilih lokasi Anda",
    LatLng? location,
    AddressStatus status = AddressStatus.initial,
    String? errorMessage,
  }) {
    return AddressState._(
      address: address,
      location:
          location ?? LatLng(-6.2088, 106.8456), // Default Jakarta location
      status: status,
      errorMessage: errorMessage,
    );
  }

  AddressState copyWith({
    String? address,
    LatLng? location,
    AddressStatus? status,
    String? errorMessage,
  }) {
    return AddressState(
      address: address ?? this.address,
      location: location ?? this.location,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [address, location, status, errorMessage];
}
