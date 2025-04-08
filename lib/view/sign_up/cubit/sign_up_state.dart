part of 'sign_up_cubit.dart';

enum SignupStatus { initial, loading, success, error }

class SignupState {
  final SignupStatus status;
  final String errorMessage;

  const SignupState({required this.status, required this.errorMessage});

  factory SignupState.initial() =>
      const SignupState(status: SignupStatus.initial, errorMessage: '');

  SignupState copyWith({SignupStatus? status, String? errorMessage}) {
    return SignupState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
