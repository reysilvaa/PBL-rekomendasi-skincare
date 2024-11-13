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
    on<UpdateFirstNameEvent>(_onUpdateFirstName);
    on<UpdateLastNameEvent>(_onUpdateLastName);
    on<UpdateEmailEvent>(_onUpdateEmail);
    on<UpdateBirthDateEvent>(_onUpdateBirthDate);
    on<UpdatePhoneNumberEvent>(_onUpdatePhoneNumber);
    on<UpdateProfileImageEvent>(_onUpdateProfileImage); // New event handler
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

  Future<void> _onUpdateUsername(
      UpdateUsernameEvent event, Emitter<UserState> emit) async {
    try {
      final currentUser = (state is UserLoaded)
          ? (state as UserLoaded).user
          : User(username: '');
      final updatedUser = await _userInfoService.updateUserProfile(
        currentUser.copyWith(username: event.newUsername),
      );
      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdatePhoneNumber(
      UpdatePhoneNumberEvent event, Emitter<UserState> emit) async {
    try {
      final currentUser = (state is UserLoaded)
          ? (state as UserLoaded).user
          : User(username: '');
      final updatedUser = await _userInfoService.updateUserProfile(
        currentUser.copyWith(phoneNumber: event.newPhoneNumber),
      );
      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdateFirstName(
      UpdateFirstNameEvent event, Emitter<UserState> emit) async {
    try {
      final currentUser = (state is UserLoaded)
          ? (state as UserLoaded).user
          : User(username: '');
      final updatedUser = await _userInfoService.updateUserProfile(
        currentUser.copyWith(firstName: event.newFirstName),
      );
      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdateLastName(
      UpdateLastNameEvent event, Emitter<UserState> emit) async {
    try {
      final currentUser = (state is UserLoaded)
          ? (state as UserLoaded).user
          : User(username: '');
      final updatedUser = await _userInfoService.updateUserProfile(
        currentUser.copyWith(lastName: event.newLastName),
      );
      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdateEmail(
      UpdateEmailEvent event, Emitter<UserState> emit) async {
    try {
      final currentUser = (state is UserLoaded)
          ? (state as UserLoaded).user
          : User(username: '');
      final updatedUser = await _userInfoService.updateUserProfile(
        currentUser.copyWith(email: event.newEmail),
      );
      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdateBirthDate(
      UpdateBirthDateEvent event, Emitter<UserState> emit) async {
    try {
      final currentUser = (state is UserLoaded)
          ? (state as UserLoaded).user
          : User(username: '');
      final updatedUser = await _userInfoService.updateUserProfile(
        currentUser.copyWith(birthDate: event.newBirthDate),
      );
      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onUpdateProfileImage(
      UpdateProfileImageEvent event, Emitter<UserState> emit) async {
    try {
      final currentUser = (state is UserLoaded)
          ? (state as UserLoaded).user
          : User(username: ''); // Fallback user if state is not loaded

      // Update profile image using the service
      final updatedUser = await _userInfoService.updateUserProfile(
        currentUser.copyWith(profileImage: event.newProfileImageUrl),
      );
      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }
}
