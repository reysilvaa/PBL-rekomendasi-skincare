import 'package:equatable/equatable.dart';
import '../../model/user.dart';

// Abstract class for UserState
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

// Initial state when the user data is not loaded yet
class UserInitial extends UserState {}

// Loading state while waiting for the data (optional for indicating loading)
class UserLoading extends UserState {}

// Loaded state when the user data is successfully fetched or updated
class UserLoaded extends UserState {
  final User user;

  const UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

// Error state when something goes wrong (e.g., failed to fetch user data)
class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserUpdated extends UserState {
  final User updatedUser;

  const UserUpdated(this.updatedUser);

  @override
  List<Object?> get props => [updatedUser];
  }
