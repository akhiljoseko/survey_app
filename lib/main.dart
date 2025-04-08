import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/app/survey_app.dart';
import 'package:school_surveys/data/authentication/authentication_repository_impl.dart';
import 'package:school_surveys/data/authentication/authentication_service.dart';
import 'package:school_surveys/domain/authentication/authentication_repository.dart';
import 'package:school_surveys/view/authentication/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authService = AuthenticationService();
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
