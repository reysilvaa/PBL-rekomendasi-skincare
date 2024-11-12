// lib/blocs/user/user_event.dart
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserEvent extends UserEvent {
  final String token;

  const FetchUserEvent(this.token);

  @override
  List<Object?> get props => [token];
}
