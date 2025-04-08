import 'package:school_surveys/core/app_exception.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/data/authentication/authentication_service.dart';
import 'package:school_surveys/domain/authentication/authenticated_user.dart';
import 'package:school_surveys/domain/authentication/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationService _service;

  AuthenticationRepositoryImpl(this._service);

  @override
  Future<void> signOut() => _service.signOut();

  @override
  Stream<AuthenticatedUser?> get authStateChanges => _service.authStateChanges;

  @override
  Future<Result<AuthenticatedUser>> loginWithEmailAndPassword({
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
  Future<Result<AuthenticatedUser>> createUserAccount({
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
}
