import 'package:school_surveys/domain/authentication/authenticated_user.dart';

abstract interface class AuthenticationRepository {
  Future<void> signOut();
  Stream<AuthenticatedUser?> get authStateChanges;
}
