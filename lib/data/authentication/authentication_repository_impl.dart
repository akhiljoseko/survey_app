import 'package:school_surveys/core/app_exception.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/data/authentication/authentication_service.dart';
import 'package:school_surveys/domain/entities/user.dart';
import 'package:school_surveys/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationService _service;

  AuthenticationRepositoryImpl(this._service);

  @override
  Future<void> signOut() => _service.signOut();

  @override
  Stream<User?> get authStateChanges => _service.authStateChanges;

  @override
  Future<Result<User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _service.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result.ok(user);
    } on AppException catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(UnknownException());
    }
  }

  @override
  Future<Result<User>> createUserAccount({
    required String fullName,
    required String email,
    required String password,
    String? profileImageUrl,
  }) async {
    try {
      final registeredUser = await _service.createUserAccount(
        fullName: fullName,
        email: email,
        password: password,
        profileImageUrl: profileImageUrl,
      );
      return Result.ok(registeredUser);
    } on AppException catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(UnknownException());
    }
  }

  @override
  Future<Result<bool>> sendPasswordResetEmail(String email) async {
    try {
      final isEmailSent = await _service.sendPasswordResetEmail(email);
      return Result.ok(isEmailSent);
    } on AppException catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(UnknownException());
    }
  }
}
