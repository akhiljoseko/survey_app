import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/domain/authentication/authentication_repository.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthenticationRepository _authRepository;

  ForgotPasswordCubit(this._authRepository)
    : super(const ForgotPasswordInitial());

  Future<void> sendResetLink(String email) async {
    emit(ForgotPasswordLoading());

    final passwordResetResult = await _authRepository.sendPasswordResetEmail(
      email,
    );
    switch (passwordResetResult) {
      case Ok<bool>():
        emit(ForgotPasswordSuccess());
      case Error<bool>():
        emit(ForgotPasswordFailure(passwordResetResult.error.message));
    }
  }
}
