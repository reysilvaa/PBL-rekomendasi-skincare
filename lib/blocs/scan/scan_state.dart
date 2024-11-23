import 'package:deteksi_jerawat/model/recommendation.dart';
import 'package:equatable/equatable.dart';

abstract class ScanState extends Equatable {
  const ScanState();

  @override
  List<Object?> get props => [];
}

class ScanInitial extends ScanState {}

class ScanLoading extends ScanState {}

class ScanSuccess extends ScanState {
  final Recommendation recommendation;

  const ScanSuccess(this.recommendation);

  @override
  List<Object?> get props => [recommendation];
}

class ScanError extends ScanState {
  final String message;

  const ScanError(this.message);

  @override
  List<Object?> get props => [message];
}
