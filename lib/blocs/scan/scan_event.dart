import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class ScanEvent extends Equatable {
  const ScanEvent();

  @override
  List<Object?> get props => [];
}

// Event for analyzing the image
class AnalyzeImageEvent extends ScanEvent {
  final File image;
  final String token;

  const AnalyzeImageEvent(this.image, this.token);

  @override
  List<Object?> get props => [image, token];
}

// Event for picking and analyzing image
class PickAndAnalyzeImageEvent extends ScanEvent {
  final String token;

  const PickAndAnalyzeImageEvent(this.token);

  @override
  List<Object?> get props => [token];
}
