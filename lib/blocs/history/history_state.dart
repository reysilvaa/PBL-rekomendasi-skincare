import 'package:equatable/equatable.dart';
import 'package:deteksi_jerawat/model/history.dart';

abstract class HistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<History> histories;

  HistoryLoaded(this.histories);

  @override
  List<Object?> get props => [histories];
}

class HistoryAdded extends HistoryState {
  final History history;

  HistoryAdded(this.history);

  @override
  List<Object?> get props => [history];
}

class HistoryUpdated extends HistoryState {
  final History updatedHistory;

  HistoryUpdated(this.updatedHistory);

  @override
  List<Object?> get props => [updatedHistory];
}

class HistoryDeleted extends HistoryState {
  final int historyId;

  HistoryDeleted(this.historyId);

  @override
  List<Object?> get props => [historyId];
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
