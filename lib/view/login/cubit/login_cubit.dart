import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/domain/entities/user.dart';
import 'package:school_surveys/domain/repository/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginState.initial());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final userLoginResult = await _authRepository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
    switch (userLoginResult) {
      case Ok<User>():
        emit(state.copyWith(isLoading: false, success: true));
      case Error<User>():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: userLoginResult.error.message,
          ),
        );
    }
  }
}
