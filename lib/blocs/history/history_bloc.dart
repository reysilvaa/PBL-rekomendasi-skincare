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
  Future<void> _onFetchHistories(
      FetchHistories event, Emitter<HistoryState> emit) async {
    await _handleHistoryAction(
      () async => await _historyService.fetchUserHistory(),
      emit,
      (data) => HistoryLoaded(data),
    );
  }

  Future<void> _onAddHistory(
      AddHistory event, Emitter<HistoryState> emit) async {
    await _handleHistoryAction(
      () async => await _historyService.addHistory(event.history),
      emit,
      (data) => HistoryAdded(data),
    );
  }

  Future<void> _onUpdateHistory(
      UpdateHistory event, Emitter<HistoryState> emit) async {
    await _handleHistoryAction(
      () async => await _historyService.updateHistory(event.history),
      emit,
      (data) => HistoryUpdated(data),
    );
  }

  Future<void> _onDeleteHistory(
      DeleteHistory event, Emitter<HistoryState> emit) async {
    await _handleHistoryAction(
      () async {
        await _historyService.deleteHistory(event.historyId);
        return event.historyId; // Return the ID of the deleted history
      },
      emit,
      (data) => HistoryDeleted(data),
    );
  }

  Future<void> _handleHistoryAction(
      Future<dynamic> Function() action,
      Emitter<HistoryState> emit,
      HistoryState Function(dynamic data) onSuccess) async {
    try {
      emit(HistoryLoading()); // Emit loading state
      final result =
          await action(); // Perform the action (e.g., fetch, add, update)
      emit(onSuccess(result)); // Emit the success state with the result
    } catch (error) {
      // Emit error state with a better formatted error message
      emit(HistoryError('An error occurred: $error'));
    }
  }
}
