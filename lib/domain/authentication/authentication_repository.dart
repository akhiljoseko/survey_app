import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/domain/authentication/authenticated_user.dart';

abstract interface class AuthenticationRepository {
  Stream<AuthenticatedUser?> get authStateChanges;

  Future<Result<AuthenticatedUser>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Result<AuthenticatedUser>> createUserAccount({
    required String fullName,
    required String email,
    required String password,
    String? profileImageUrl,
  });

  Future<Result<bool>> sendPasswordResetEmail(String email);

  Future<void> signOut();
}
