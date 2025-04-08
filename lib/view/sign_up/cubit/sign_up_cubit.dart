import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/domain/authentication/authenticated_user.dart';
import 'package:school_surveys/domain/authentication/authentication_repository.dart';

part 'sign_up_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthenticationRepository _authRepository;

  SignupCubit(this._authRepository) : super(SignupState.initial());

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    String? profileImageUrl,
  }) async {
    emit(state.copyWith(status: SignupStatus.loading));

    final signUpResult = await _authRepository.createUserAccount(
      fullName: fullName,
      email: email,
      password: password,
      profileImageUrl: profileImageUrl,
    );
    switch (signUpResult) {
      case Ok<AuthenticatedUser>():
        emit(state.copyWith(status: SignupStatus.success));
      case Error<AuthenticatedUser>():
        emit(
          state.copyWith(
            status: SignupStatus.error,
            errorMessage: signUpResult.error.message,
          ),
        );
    }
  }
}
