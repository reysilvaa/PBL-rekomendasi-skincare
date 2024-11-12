// lib/blocs/user/user_bloc.dart
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
  }

  Future<void> _onFetchUser(
    FetchUserEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      // emit(UserLoading());
      final user = await _userInfoService.fetchUserInfo(event.token);
      emit(UserLoaded(user));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }
}
