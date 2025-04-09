part of 'auth_cubit.dart';

class AuthState {
  final AuthStatus status;
  final User? user;

  const AuthState({required this.status, this.user});

  AuthState copyWith({AuthStatus? status, User? user}) {
    return AuthState(status: status ?? this.status, user: user ?? this.user);
  }
}
