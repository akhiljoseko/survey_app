import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_surveys/app/routing/app_routes.dart';
import 'package:school_surveys/view/add_survey/add_survey_screen.dart';
import 'package:school_surveys/view/authentication/auth_cubit.dart';
import 'package:school_surveys/view/edit_survey/edit_survey_screen.dart';
import 'package:school_surveys/view/forgot_password/forgot_password_screen.dart';
import 'package:school_surveys/view/sign_up/sign_up_screen.dart';
import 'package:school_surveys/view/splash/splash_screen.dart';
import 'package:school_surveys/view/survey_commencement/survey_commencement_screen.dart';
import 'package:school_surveys/view/survey_meta_view/suvey_meta_view_screen.dart';

import '../../view/home/home_screen.dart';
import '../../view/login/login_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final authStatus = context.read<AuthCubit>().state.status;
    final loggingIn = state.matchedLocation.startsWith('/login');
    final isSplash = state.matchedLocation.startsWith('/splash');

    if (authStatus == AuthStatus.unknown) return '/splash';

    if (authStatus == AuthStatus.unauthenticated && !loggingIn) {
      return '/login';
    }

    if (authStatus == AuthStatus.authenticated && (loggingIn || isSplash)) {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/splash',
      name: AppRoutes.splash,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: AppRoutes.login,
      builder: (_, _) => LoginScreen(),
      routes: [
        GoRoute(
          path: 'signup',
          name: AppRoutes.signup,
          builder: (_, _) => SignupScreen(),
        ),
        GoRoute(
          path: 'passwordreset',
          name: AppRoutes.resetPassword,
          builder: (_, _) => ForgotPasswordScreen(),
        ),
      ],
    ),

    GoRoute(
      path: '/',
      name: AppRoutes.home,
      builder: (context, state) {
        final tabIndex = state.uri.queryParameters['tab'];
        return HomeScreen(tabIndex: tabIndex);
      },
      routes: [
        GoRoute(
          path: "survey/add",
          name: AppRoutes.addSurvey,
          builder: (_, _) {
            return const AddSurveyScreen();
          },
        ),
        GoRoute(
          path: "survey/:id/commencement",
          name: AppRoutes.surveyCommencement,
          builder: (_, state) {
            final surveyId = state.pathParameters['id'];
            return SurveyCommencementScreen(surveyId: surveyId!);
          },
        ),
        GoRoute(
          path: "survey/:id/view",
          name: AppRoutes.viewSurvey,
          builder: (_, state) {
            final surveyId = state.pathParameters['id'];
            return SurveyMetaViewScreen(surveyId: surveyId!);
          },
        ),
        GoRoute(
          path: "survey/:id/edit",
          name: AppRoutes.editSurvey,
          builder: (_, state) {
            final surveyId = state.pathParameters['id'];
            return EditSurveyScreen(surveyId: surveyId!);
          },
        ),
      ],
    ),
  ],
);
