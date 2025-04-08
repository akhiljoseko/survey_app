import 'dart:async';

import 'package:school_surveys/data/authentication/authentication_exceptions.dart';
import 'package:school_surveys/domain/authentication/authenticated_user.dart';

class AuthenticationService {
  AuthenticationService();

  final _authStateStreamController =
      StreamController<AuthenticatedUser?>.broadcast();
  Stream<AuthenticatedUser?> get authStateChanges async* {
    yield null;
    await Future.delayed(Duration(seconds: 1));
    // yield AuthenticatedUser(
    //   uid: "sdasd",
    //   email: "akhil@email.com",
    //   displayName: "Akhil Jose",
    // );
    yield* _authStateStreamController.stream;
  }

  Future<bool> signOut() async {
    _authStateStreamController.add(null);
    return true;
  }

  Future<AuthenticatedUser> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    if (email == "akhil@test.com" && password == "12345678") {
      final user = AuthenticatedUser(
        uid: "adfsdf",
        email: email,
        displayName: "Akhil Jose",
      );
      _authStateStreamController.add(user);
      return user;
    }
    throw InvalidCredentialsException();
  }
}
