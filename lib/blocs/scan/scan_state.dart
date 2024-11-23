import 'package:deteksi_jerawat/model/scan.dart';
import 'package:equatable/equatable.dart';
import 'package:deteksi_jerawat/model/history.dart';

abstract class ScanState extends Equatable {
  const ScanState();

  @override
  List<Object?> get props => [];
}

// Initial state
class ScanInitial extends ScanState {}

// Loading state
class ScanLoading extends ScanState {}

// Success state with History object
class ScanSuccess extends ScanState {
  final Scan
      scan; // This holds the history data returned from the scan service

  const ScanSuccess(this.scan);

  @override
  List<Object?> get props => [scan];

}

// Error state with message
class ScanError extends ScanState {
  final String message;

  const ScanError(this.message);

  @override
  List<Object?> get props => [message];
}
