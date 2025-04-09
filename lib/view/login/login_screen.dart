import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_surveys/app/routing/app_routes.dart';
import 'package:school_surveys/domain/repository/authentication_repository.dart';
import 'package:school_surveys/utils/loading_indicator.dart';
import 'package:school_surveys/utils/snackbar_utils.dart';
import 'package:school_surveys/utils/validation_utils.dart';
import 'package:school_surveys/view/login/cubit/login_cubit.dart';
import 'package:school_surveys/view/widgets/email_textfield.dart';
import 'package:school_surveys/view/widgets/password_textfield.dart';
import 'package:school_surveys/view/widgets/primary_button.dart';
import 'package:school_surveys/view/widgets/question_button.dart';
import 'package:school_surveys/view/widgets/spacing.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthenticationRepository>()),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.isLoading) {
              LoadingIndicator.showLoading(context);
              return;
            }
            LoadingIndicator.removeLoading(context);
            if (state.errorMessage != null) {
              SnackbarUtils.showErrorSnackbar(
                context,
                message: state.errorMessage!,
              );
            }
          },
          buildWhen: (previous, current) => false,
          builder: (context, state) {
            return ScreenPadding(
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Welcome back!",
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Sign in to continue",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Vspace(20),
                        EmailTextField(
                          controller: _emailController,
                          validator: ValidationUtils.validateEmail,
                        ),
                        PasswordTextField(
                          controller: _passwordController,
                          validator: ValidationUtils.validatePassword,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed:
                                () => context.goNamed(AppRoutes.resetPassword),
                            child: Text("Forgot password?"),
                          ),
                        ),
                        PrimaryButton(
                          onPressed: () => _submit(context),
                          label: "Sign in",
                        ),
                        Vspace(12),
                        QuestionButton(
                          question: "Don't have an account? ",
                          buttonText: "Sign up",
                          onPressed: () => context.goNamed(AppRoutes.signup),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    context.read<LoginCubit>().login(email, password);
  }
}
