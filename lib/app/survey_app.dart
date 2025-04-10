import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/app/routing/router.dart';
import 'package:school_surveys/view/authentication/auth_cubit.dart';

class SurveyApp extends StatelessWidget {
  const SurveyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) => router.refresh(),
      builder: (context, state) {
        return MaterialApp.router(
          routerConfig: router,
          themeMode: ThemeMode.light,
          darkTheme: ThemeData.dark(),
          theme: ThemeData.light(),
        );
      },
    );
  }
}
