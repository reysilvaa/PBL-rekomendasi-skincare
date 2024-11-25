import 'package:equatable/equatable.dart';
import '../../model/user.dart';

// Abstract class for UserEvent
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

// Event to fetch the user data
class FetchUserEvent extends UserEvent {
  final String token;
  const FetchUserEvent(this.token);

  @override
  List<Object?> get props => [token];
}

// Event to update the user's profile
class UpdateUserProfileEvent extends UserEvent {
  final User user;
  const UpdateUserProfileEvent(this.user);

  @override
  List<Object?> get props => [user];
}

// Event to update a specific user field
class UpdateUserFieldEvent extends UserEvent {
  final String field;
  final String value;
  const UpdateUserFieldEvent(this.field, this.value);

  @override
  List<Object?> get props => [field, value];
}

// UserErrorEvent: Define an event that handles error states
class UserErrorEvent extends UserEvent {
  final String message;
  const UserErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}
