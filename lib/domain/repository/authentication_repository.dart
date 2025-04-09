import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/domain/entities/user.dart';

abstract interface class AuthenticationRepository {
  Stream<User?> get authStateChanges;

  Future<Result<User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Result<User>> createUserAccount({
    required String fullName,
    required String email,
    required String password,
    String? profileImageUrl,
  });

  Future<Result<bool>> sendPasswordResetEmail(String email);

  Future<Result<List<User>>> getAllUsers();

  Future<void> signOut();
}
