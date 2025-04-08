import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_surveys/app/routing/app_routes.dart';
import 'package:school_surveys/view/authentication/auth_cubit.dart';
import 'package:school_surveys/view/sign_up/sign_up_screen.dart';

import '../../view/home/home_screen.dart';
import '../../view/login/login_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final authStatus = context.read<AuthCubit>().state.status;
    final loggingIn = state.matchedLocation.startsWith('/login');

    //Add Splash here
    if (authStatus == AuthStatus.unknown) return '/login';

    if (authStatus == AuthStatus.unauthenticated && !loggingIn) {
      return '/login';
    }

    if (authStatus == AuthStatus.authenticated && loggingIn) {
      return '/';
    }

    return null;
  },
  routes: [
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
      ],
    ),

    GoRoute(
      path: '/',
      name: AppRoutes.home,
      builder: (context, state) => HomeScreen(),
    ),
  ],
);
