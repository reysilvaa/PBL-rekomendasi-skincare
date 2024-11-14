import 'package:equatable/equatable.dart';
import 'package:deteksi_jerawat/model/history.dart';

abstract class HistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchHistories extends HistoryEvent {}

class AddHistory extends HistoryEvent {
  final History history;

  AddHistory(this.history);

  @override
  List<Object?> get props => [history];
}

class UpdateHistory extends HistoryEvent {
  final History history;

  UpdateHistory(this.history);

  @override
  List<Object?> get props => [history];
}

class DeleteHistory extends HistoryEvent {
  final int historyId;

  DeleteHistory(this.historyId);

  @override
  List<Object?> get props => [historyId];
}
