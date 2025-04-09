import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/domain/entities/user.dart';
import 'package:school_surveys/domain/authentication/authentication_repository.dart';

part 'auth_state.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository _authRepo;

  AuthCubit(this._authRepo)
    : super(const AuthState(status: AuthStatus.unknown)) {
    _authStateSubscription = _authRepo.authStateChanges.listen(
      _updateAuthState,
    );
  }

  late final StreamSubscription<User?> _authStateSubscription;

  void _updateAuthState(User? user) {
    final isLoggedIn = user != null;
    if (!isLoggedIn) {
      emit(const AuthState(status: AuthStatus.unauthenticated));
    } else {
      emit(AuthState(status: AuthStatus.authenticated, user: user));
    }
  }

  void logout() async {
    await _authRepo.signOut();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}
