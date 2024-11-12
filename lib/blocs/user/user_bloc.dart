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
    on<UpdateUsernameEvent>(_onUpdateUsername);
  }

  Future<void> _onFetchUser(
      FetchUserEvent event, Emitter<UserState> emit) async {
    // emit(UserLoading());
    try {
      final user = await _userInfoService.fetchUserInfo();
      emit(UserLoaded(user));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdateUserProfile(
      UpdateUserProfileEvent event, Emitter<UserState> emit) async {
    // emit(UserLoading());
    try {
      final updatedUser = await _userInfoService.updateUserProfile(event.user);
      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdateUsername(
      UpdateUsernameEvent event, Emitter<UserState> emit) async {
    // emit(UserLoading());
    try {
      final updatedUser = await _userInfoService
          .updateUserProfile(User(username: event.newUsername));
      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdatePhoneNumber(
      UpdatePhoneNumberEvent event, Emitter<UserState> emit) async {
    // emit(UserLoading());
    try {
      // Get the current user data, assuming it's already loaded
      final currentUser = (state as UserLoaded).user;

      // Make sure the current username is passed along with the updated phone number
      final updatedUser = await _userInfoService.updateUserProfile(
        User(
          username: currentUser.username, // Keep the existing username
          phoneNumber: event.newPhoneNumber,
          // You can add other fields that you want to update if necessary
        ),
      );

      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdateFirstName(
      UpdateFirstNameEvent event, Emitter<UserState> emit) async {
    // emit(UserLoading());
    try {
      // Get the current user data, assuming it's already loaded
      final currentUser = (state as UserLoaded).user;

      // Make sure the current username is passed along with the updated phone number
      final updatedUser = await _userInfoService.updateUserProfile(
        User(
          username: currentUser.username, // Keep the existing username
          firstName: event.newFirstName,
          // You can add other fields that you want to update if necessary
        ),
      );

      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdatelastName(
      UpdateLastNameEvent event, Emitter<UserState> emit) async {
    // emit(UserLoading());
    try {
      // Get the current user data, assuming it's already loaded
      final currentUser = (state as UserLoaded).user;

      // Make sure the current username is passed along with the updated phone number
      final updatedUser = await _userInfoService.updateUserProfile(
        User(
          username: currentUser.username, // Keep the existing username
          lastName: event.newLastName,
          // You can add other fields that you want to update if necessary
        ),
      );

      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdateEmail(
      UpdateEmailEvent event, Emitter<UserState> emit) async {
    // emit(UserLoading());
    try {
      // Get the current user data, assuming it's already loaded
      final currentUser = (state as UserLoaded).user;

      // Make sure the current username is passed along with the updated phone number
      final updatedUser = await _userInfoService.updateUserProfile(
        User(
          username: currentUser.username, // Keep the existing username
          email: event.newEmail,
          // You can add other fields that you want to update if necessary
        ),
      );

      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdateBirthDate(
      UpdateBirthDateEvent event, Emitter<UserState> emit) async {
    // emit(UserLoading());
    try {
      // Get the current user data, assuming it's already loaded
      final currentUser = (state as UserLoaded).user;

      // Make sure the current username is passed along with the updated phone number
      final updatedUser = await _userInfoService.updateUserProfile(
        User(
          username: currentUser.username, // Keep the existing username
          birthDate: event.newBirthDate,
          // You can add other fields that you want to update if necessary
        ),
      );

      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }
}
