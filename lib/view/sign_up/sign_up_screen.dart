import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_surveys/app/routing/app_routes.dart';
import 'package:school_surveys/domain/authentication/authentication_repository.dart';
import 'package:school_surveys/utils/loading_indicator.dart';
import 'package:school_surveys/utils/snackbar_utils.dart';
import 'package:school_surveys/utils/validation_utils.dart';
import 'package:school_surveys/view/sign_up/cubit/sign_up_cubit.dart';
import 'package:school_surveys/view/widgets/email_textfield.dart';
import 'package:school_surveys/view/widgets/password_textfield.dart';
import 'package:school_surveys/view/widgets/primary_button.dart';
import 'package:school_surveys/view/widgets/question_button.dart';
import 'package:school_surveys/view/widgets/spacing.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocProvider(
        create:
            (context) => SignupCubit(context.read<AuthenticationRepository>()),
        child: SafeArea(
          child: ScreenPadding(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: Column(
                    children: [
                      Text(
                        'Create Account',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Sign up to continue"),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _fullNameController,
                        validator: ValidationUtils.validateName,
                        decoration: InputDecoration(
                          helperText: "",
                          prefixIcon: Icon(Icons.person_outline),
                          labelText: "Full Name",
                        ),
                      ),
                      EmailTextField(
                        controller: _emailController,
                        validator: ValidationUtils.validateEmail,
                      ),
                      PasswordTextField(
                        controller: _passwordController,
                        validator: ValidationUtils.validatePassword,
                      ),
                      Vspace(24),
                      BlocConsumer<SignupCubit, SignupState>(
                        listener: (context, state) {
                          if (state.status == SignupStatus.loading) {
                            LoadingIndicator.showLoading(
                              context,
                              loadingMessage: "Creating account",
                            );
                            return;
                          }
                          LoadingIndicator.removeLoading(context);
                          if (state.status == SignupStatus.error) {
                            SnackbarUtils.showErrorSnackbar(
                              context,
                              message: state.errorMessage,
                            );
                          }
                        },
                        builder: (context, state) {
                          return PrimaryButton(
                            onPressed: () => _signup(context),
                            label: "Sign up",
                          );
                        },
                      ),
                      Vspace(12),
                      QuestionButton(
                        question: "Already have an account? ",
                        buttonText: "Sign in",
                        onPressed: () {
                          context.goNamed(AppRoutes.login);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signup(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }
    context.read<SignupCubit>().register(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }
}
