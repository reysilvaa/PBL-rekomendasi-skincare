import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deteksi_jerawat/services/history-info.dart';
import 'package:deteksi_jerawat/model/history.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryService _historyService;

  HistoryBloc({required HistoryService historyService})
      : _historyService = historyService,
        super(HistoryInitial()) {
    // Registering events to respective methods
    on<FetchHistories>(_onFetchHistories);
    on<AddHistory>(_onAddHistory);
    on<UpdateHistory>(_onUpdateHistory);
    on<DeleteHistory>(_onDeleteHistory);
  }

  // Fetch histories
  Future<void> _onFetchHistories(
      FetchHistories event, Emitter<HistoryState> emit) async {
    try {
      emit(HistoryLoading());
      final histories =
          await _historyService.fetchUserHistory(); // Fetch from the service
      emit(HistoryLoaded(histories)); // Emit loaded state with data
    } catch (error) {
      emit(HistoryError('Failed to fetch histories: $error'));
    }
  }

  // Add a new history
  Future<void> _onAddHistory(
      AddHistory event, Emitter<HistoryState> emit) async {
    try {
      emit(HistoryLoading());
      final history = await _historyService
          .addHistory(event.history); // Add history via service
      emit(HistoryAdded(history)); // Emit added state with the new history
    } catch (error) {
      emit(HistoryError('Failed to add history: $error'));
    }
  }

  // Update an existing history
  Future<void> _onUpdateHistory(
      UpdateHistory event, Emitter<HistoryState> emit) async {
    try {
      emit(HistoryLoading());
      final updatedHistory = await _historyService
          .updateHistory(event.history); // Update via service
      emit(HistoryUpdated(
          updatedHistory)); // Emit updated state with the updated history
    } catch (error) {
      emit(HistoryError('Failed to update history: $error'));
    }
  }

  // Delete a history
  Future<void> _onDeleteHistory(
      DeleteHistory event, Emitter<HistoryState> emit) async {
    try {
      emit(HistoryLoading());
      await _historyService
          .deleteHistory(event.historyId); // Delete history via service
      emit(HistoryDeleted(
          event.historyId)); // Emit deleted state with the deleted ID
    } catch (error) {
      emit(HistoryError('Failed to delete history: $error'));
    }
  }
}
