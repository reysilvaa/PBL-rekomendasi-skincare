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

// Event to update the username
class UpdateUsernameEvent extends UserEvent {
  final String newUsername;

  const UpdateUsernameEvent(this.newUsername);

  @override
  List<Object> get props => [newUsername];
}

// Event to update the phone num
class UpdatePhoneNumberEvent extends UserEvent {
  final String newPhoneNumber;

  const UpdatePhoneNumberEvent(this.newPhoneNumber);

  @override
  List<Object> get props => [newPhoneNumber];
}

class UpdateFirstNameEvent extends UserEvent {
  final String newFirstName;

  const UpdateFirstNameEvent(this.newFirstName);

  @override
  List<Object> get props => [newFirstName];
}

class UpdateLastNameEvent extends UserEvent {
  final String newLastName;

  const UpdateLastNameEvent(this.newLastName);

  @override
  List<Object> get props => [newLastName];
}

class UpdateEmailEvent extends UserEvent {
  final String newEmail;

  const UpdateEmailEvent(this.newEmail);

  @override
  List<Object> get props => [newEmail];
}

class UpdateBirthDateEvent extends UserEvent {
  final String newBirthDate;

  const UpdateBirthDateEvent(this.newBirthDate);

  @override
  List<Object> get props => [newBirthDate];
}

// UserErrorEvent: Define an event that handles error states
class UserErrorEvent extends UserEvent {
  final String message;

  const UserErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}

// Event to update the user's profile image
class UpdateProfileImageEvent extends UserEvent {
  final String newProfileImageUrl;

  const UpdateProfileImageEvent(this.newProfileImageUrl);

  @override
  List<Object?> get props => [newProfileImageUrl];
}
