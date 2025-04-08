import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/domain/authentication/authentication_repository.dart';
import 'package:school_surveys/utils/loading_indicator.dart';
import 'package:school_surveys/utils/snackbar_utils.dart';
import 'package:school_surveys/utils/validation_utils.dart';
import 'package:school_surveys/view/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:school_surveys/view/widgets/email_textfield.dart';
import 'package:school_surveys/view/widgets/primary_button.dart';
import 'package:school_surveys/view/widgets/spacing.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: ScreenPadding(
        child: BlocProvider(
          create:
              (context) =>
                  ForgotPasswordCubit(context.read<AuthenticationRepository>()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Vspace(24),
              Text(
                "Reset Password",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Vspace(12),
              Text(
                "Enter the email associated with your account and we'll send an email with instructions to reset your password.",
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: EmailTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  validator: ValidationUtils.validateEmail,
                ),
              ),
              const SizedBox(height: 24),
              BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                listener: (context, state) {
                  if (state is ForgotPasswordLoading) {
                    LoadingIndicator.showLoading(context);
                    return;
                  }
                  LoadingIndicator.removeLoading(context);
                  if (state is ForgotPasswordSuccess) {
                    SnackbarUtils.showSuccessSnackbar(
                      context,
                      message: "Password reset link sent",
                    );
                    Navigator.pop(context);
                  } else if (state is ForgotPasswordFailure) {
                    SnackbarUtils.showErrorSnackbar(
                      context,
                      message: state.message,
                    );
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    onPressed: () => _sendPasswordResetEmail(context),
                    label: "Send Instructions",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendPasswordResetEmail(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }
    context.read<ForgotPasswordCubit>().sendResetLink(
      _emailController.text.trim(),
    );
  }
}
