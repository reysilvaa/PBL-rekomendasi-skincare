import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import '../../model/recommendation.dart';
import '../../services/scan-post.dart';

// Events
abstract class ScanEvent extends Equatable {
  const ScanEvent();

  @override
  List<Object?> get props => [];
}

class AnalyzeImageEvent extends ScanEvent {
  final File image;
  final String token;

  const AnalyzeImageEvent(this.image, this.token);

  @override
  List<Object?> get props => [image, token];
}

class PickAndAnalyzeImageEvent extends ScanEvent {
  final String token;

  const PickAndAnalyzeImageEvent(this.token);

  @override
  List<Object?> get props => [token];
}
