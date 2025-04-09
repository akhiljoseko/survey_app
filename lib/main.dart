import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:school_surveys/app/survey_app.dart';
import 'package:school_surveys/data/authentication/authentication_repository_impl.dart';
import 'package:school_surveys/data/authentication/authentication_service.dart';
import 'package:school_surveys/data/database/hive/hive_local_database.dart';
import 'package:school_surveys/data/database/hive/hive_registrar.g.dart';
import 'package:school_surveys/domain/authentication/authentication_repository.dart';
import 'package:school_surveys/domain/entities/user.dart';
import 'package:school_surveys/view/authentication/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapters();

  final authService = AuthenticationService(
    HiveLocalDatabase<User>('users'),
    HiveLocalDatabase<User>('authenticated_user'),
  );
  final authRepo = AuthenticationRepositoryImpl(authService);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>.value(value: authRepo),
      ],
      child: BlocProvider(
        create: (_) => AuthCubit(authRepo),
        child: const SurveyApp(),
      ),
    ),
  );
}
