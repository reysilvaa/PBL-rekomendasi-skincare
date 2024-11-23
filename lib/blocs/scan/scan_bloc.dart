
// Bloc
import 'package:deteksi_jerawat/blocs/scan/scan_event.dart';
import 'package:deteksi_jerawat/blocs/scan/scan_state.dart';
import 'package:deteksi_jerawat/services/scan-post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final ScanService _scanService;

  ScanBloc({required ScanService scanService})
      : _scanService = scanService,
        super(ScanInitial()) {
    on<AnalyzeImageEvent>(_onAnalyzeImage);
    on<PickAndAnalyzeImageEvent>(_onPickAndAnalyzeImage);
  }

  Future<void> _onAnalyzeImage(
    AnalyzeImageEvent event,
    Emitter<ScanState> emit,
  ) async {
    try {
      emit(ScanLoading());
      final recommendation =
          await _scanService.analyzeImage(event.image, event.token);
      emit(ScanSuccess(recommendation));
    } catch (e) {
      emit(ScanError(e.toString()));
    }
  }

  Future<void> _onPickAndAnalyzeImage(
    PickAndAnalyzeImageEvent event,
    Emitter<ScanState> emit,
  ) async {
    try {
      emit(ScanLoading());
      final recommendation =
          await _scanService.pickAndAnalyzeImage(token: event.token);
      emit(ScanSuccess(recommendation));
    } catch (e) {
      emit(ScanError(e.toString()));
    }
  }
}