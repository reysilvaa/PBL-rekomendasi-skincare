import 'package:deteksi_jerawat/blocs/user/user_event.dart';
import 'package:deteksi_jerawat/blocs/user/user_state.dart';
import 'package:deteksi_jerawat/model/user.dart';
import 'package:deteksi_jerawat/services/user-info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserInfoService _userInfoService;

  UserBloc({required UserInfoService userInfoService})
      : _userInfoService = userInfoService,
        super(UserInitial()) {
    on<FetchUserEvent>(_onFetchUser);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
    on<UpdateUserFieldEvent>(_onUpdateUserField);
  }

  // Fetch user data on event
  Future<void> _onFetchUser(
      FetchUserEvent event, Emitter<UserState> emit) async {
    try {
      // Load user data from service
      final user = await _userInfoService.fetchUserInfo();
      emit(UserLoaded(user));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  // Update user profile when event is triggered
  Future<void> _onUpdateUserProfile(
      UpdateUserProfileEvent event, Emitter<UserState> emit) async {
    try {
      final updatedUser = await _userInfoService.updateUserProfile(event.user);
      emit(UserLoaded(updatedUser)); // Emit updated user if successful
    } catch (e) {
      // Check if the error is a HTTP error, like 422 (Unprocessable Entity)
      if (e is Exception || e is Error) {
        // You can also check the error message if it's an HTTP error
        emit(UserError('Failed to update profile: $e'));
      } else {
        emit(UserError('Unknown error occurred: $e'));
      }
    }
  }

  // Update specific user field when event is triggered
  Future<void> _onUpdateUserField(
      UpdateUserFieldEvent event, Emitter<UserState> emit) async {
    try {
      final currentUser = (state is UserLoaded)
          ? (state as UserLoaded).user
          : const User(username: ''); // Fallback if no user is loaded

      // Create a new user with the updated field
      final updatedUser = await _userInfoService.updateUserProfile(
        _updateUserField(currentUser, event.field, event.value),
      );
      emit(UserLoaded(updatedUser)); // Emit the new user after update
    } catch (error) {
      emit(UserError(error.toString())); // Handle errors if any
    }
  }

  // Helper function to update user field dynamically
  User _updateUserField(User user, String field, String value) {
    switch (field) {
      case 'username':
        return user.copyWith(username: value);
      case 'phone_number':
        return user.copyWith(phoneNumber: value);
      case 'first_name':
        return user.copyWith(firstName: value);
      case 'last_name':
        return user.copyWith(lastName: value);
      case 'email':
        return user.copyWith(email: value);
      case 'birth_date':
        return user.copyWith(birthDate: value);
      case 'profile_image':
        return user.copyWith(profileImage: value);
      default:
        throw ArgumentError('Unknown field: $field');
    }
  }
}
