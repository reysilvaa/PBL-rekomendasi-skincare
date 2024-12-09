import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class InitializeAddressEvent extends AddressEvent {
  final String? initialAddress;
  final LatLng? initialLocation;

  const InitializeAddressEvent({this.initialAddress, this.initialLocation});

  @override
  List<Object> get props =>
      [initialAddress ?? '', initialLocation ?? LatLng(0, 0)];
}

class UpdateAddressEvent extends AddressEvent {
  final String address;
  final LatLng location;
  final VoidCallback? onChanged;

  const UpdateAddressEvent(
      {required this.address, required this.location, this.onChanged});

  @override
  List<Object> get props => [address, location];
}

class FetchCurrentLocationEvent extends AddressEvent {}
