import 'dart:async';

import 'package:school_surveys/domain/authentication/authenticated_user.dart';

class AuthenticationService {
  AuthenticationService();

  final _authStateStreamController =
      StreamController<AuthenticatedUser?>.broadcast();
  Stream<AuthenticatedUser?> get authStateChanges async* {
    yield null;
    await Future.delayed(Duration(seconds: 1));
    yield AuthenticatedUser(
      uid: "sdasd",
      email: "akhil@email.com",
      displayName: "Akhil Jose",
    );
    yield* _authStateStreamController.stream;
  }

  Future<bool> signOut() async {
    _authStateStreamController.add(null);
    return true;
  }
}
