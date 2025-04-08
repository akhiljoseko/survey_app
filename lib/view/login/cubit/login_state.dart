part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool success;
  final String? errorMessage;

  const LoginState({
    required this.isLoading,
    required this.success,
    this.errorMessage,
  });

  factory LoginState.initial() =>
      const LoginState(isLoading: false, success: false, errorMessage: null);

  LoginState copyWith({bool? isLoading, bool? success, String? errorMessage}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, success, errorMessage];
}
