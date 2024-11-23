import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deteksi_jerawat/services/scan-post.dart';
import 'package:deteksi_jerawat/blocs/scan/scan_event.dart';
import 'package:deteksi_jerawat/blocs/scan/scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final ScanService _scanService;

  ScanBloc({required ScanService scanService})
      : _scanService = scanService,
        super(ScanInitial()) {
    // Handle the image analysis
    on<AnalyzeImageEvent>(_onAnalyzeImage);
    on<PickAndAnalyzeImageEvent>(_onPickAndAnalyzeImage);
  }

  // Handle AnalyzeImageEvent
  Future<void> _onAnalyzeImage(
    AnalyzeImageEvent event,
    Emitter<ScanState> emit,
  ) async {
    try {
      emit(ScanLoading()); // Show loading while processing
      final scan = await _scanService.analyzeImage(event.image, event.token);
      emit(ScanSuccess(scan)); // Emit success with the history
    } catch (e) {
      emit(ScanError(e.toString())); // Emit error if something goes wrong
    }
  }

  // Handle PickAndAnalyzeImageEvent (for picking image from gallery)
  Future<void> _onPickAndAnalyzeImage(
    PickAndAnalyzeImageEvent event,
    Emitter<ScanState> emit,
  ) async {
    try {
      emit(ScanLoading()); // Show loading while processing
      final scan = await _scanService.pickAndAnalyzeImage(token: event.token);
      emit(ScanSuccess(scan)); // Emit success with the history
    } catch (e) {
      emit(ScanError(e.toString())); // Emit error if something goes wrong
    }
  }
}
