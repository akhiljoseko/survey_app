part of 'auth_cubit.dart';

class AuthState {
  final AuthStatus status;
  final AuthenticatedUser? user;

  const AuthState({required this.status, this.user});

  AuthState copyWith({AuthStatus? status, AuthenticatedUser? user}) {
    return AuthState(status: status ?? this.status, user: user ?? this.user);
  }
}
