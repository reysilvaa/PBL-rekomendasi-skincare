import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/user-info.dart';
import '../../model/user.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserInfoService _userInfoService;

  UserBloc({required UserInfoService userInfoService})
      : _userInfoService = userInfoService,
        super(UserInitial()) {
    on<FetchUserEvent>(_onFetchUser);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
    on<UpdateUserFieldEvent>(_onUpdateUserField);
  }

  Future<void> _onFetchUser(
      FetchUserEvent event, Emitter<UserState> emit) async {
    try {
      final user = await _userInfoService.fetchUserInfo();
      emit(UserLoaded(user));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdateUserProfile(
      UpdateUserProfileEvent event, Emitter<UserState> emit) async {
    try {
      final updatedUser = await _userInfoService.updateUserProfile(event.user);
      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdateUserField(
      UpdateUserFieldEvent event, Emitter<UserState> emit) async {
    try {
      final currentUser = (state is UserLoaded)
          ? (state as UserLoaded).user
          : const User(username: ''); // Fallback user if state is not loaded

      // Update the specific field
      final updatedUser = await _userInfoService.updateUserProfile(
        _updateUserField(currentUser, event.field, event.value),
      );
      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  // Helper method to update user field dynamically
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
