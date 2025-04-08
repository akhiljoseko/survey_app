import 'package:school_surveys/data/authentication/authentication_service.dart';
import 'package:school_surveys/domain/authentication/authenticated_user.dart';
import 'package:school_surveys/domain/authentication/authentication_repository.dart';

class AuthRepositoryImpl implements AuthenticationRepository {
  final AuthenticationService _service;

  AuthRepositoryImpl(this._service);

  @override
  Future<void> signOut() => _service.signOut();

  @override
  Stream<AuthenticatedUser?> get authStateChanges => _service.authStateChanges;
}
