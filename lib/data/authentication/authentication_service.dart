import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:school_surveys/data/database/no_sql_local_database.dart';
import 'package:school_surveys/data/authentication/authentication_exceptions.dart';
import 'package:school_surveys/domain/entities/user.dart';
import 'package:uuid/uuid.dart';

const _delayDuration = Duration(milliseconds: 600);

class AuthenticationService {
  final NoSqlLocalDatabase<User> _database;
  //This can be achieved by using shared preferences but since we are using hive
  //It is better to use hive for storing the authenticated user as well.
  final NoSqlLocalDatabase<User> _authenticatedUser;

  AuthenticationService(this._database, this._authenticatedUser);

  final _authStateStreamController = StreamController<User?>.broadcast();
  Stream<User?> get authStateChanges async* {
    yield await _getAuthenticatedUserIfAny();
    yield* _authStateStreamController.stream;
  }

  Future<User?> _getAuthenticatedUserIfAny() async {
    final user = await _authenticatedUser.getAll();
    if (user.isNotEmpty) {
      return user.first;
    }
    return null;
  }

  Future<bool> signOut() async {
    _authStateStreamController.add(null);
    await _authenticatedUser.clearCollection();
    return true;
  }

  Future<User> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(_delayDuration);
    try {
      final users = await _database.getAll();
      final user = users.firstWhere((us) => us.email == email);
      if (user.password != password) {
        throw InvalidCredentialsException();
      }
      _authStateStreamController.add(user);
      await _authenticatedUser.insert(user);
      return user;
    } on StateError catch (_) {
      throw InvalidCredentialsException();
    }
  }

  Future<User> createUserAccount({
    required String fullName,
    required String email,
    required String password,
    String? profileImageUrl,
  }) async {
    await Future.delayed(_delayDuration);

    final allUsers = await _database.getAll();
    if (allUsers.any((us) => us.email == email)) {
      throw AccountExists();
    }

    final id = Uuid().v4();
    final user = User(
      id: id,
      email: email,
      displayName: fullName,
      password: password,
      createdAt: DateTime.now().toUtc(),
    );
    await _database.insert(user);
    _authStateStreamController.add(user);
    await _authenticatedUser.insert(user);
    return user;
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    await Future.delayed(_delayDuration);
    try {
      final users = await _database.getAll();
      final user = users.firstWhere((us) => us.email == email);
      debugPrint("simulate an email sent to ${user.email}");
      return true;
    } on StateError catch (_) {
      throw AccountNotFound();
    }
  }

  Future<List<User>> getAllUsers() async {
    return await _database.getAll();
  }
}
