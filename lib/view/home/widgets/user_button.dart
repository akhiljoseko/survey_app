import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_surveys/app/routing/app_routes.dart';
import 'package:school_surveys/utils/snackbar_utils.dart';
import 'package:school_surveys/view/authentication/auth_cubit.dart';
import 'package:school_surveys/view/widgets/user_circle_avatar.dart';
import 'package:school_surveys/view/widgets/spacing.dart';

class UserButton extends StatefulWidget {
  const UserButton({super.key});

  @override
  State<UserButton> createState() => _UserButtonState();
}

class _UserButtonState extends State<UserButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen:
          (previous, current) => current.status == AuthStatus.authenticated,
      builder: (context, state) {
        final user = state.user!;
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return _ProfileDialog(
                  avatarUrl: user.photoURL,
                  name: user.displayName,
                  email: user.email,
                );
              },
            );
          },

          child: UserCircleAvatar(
            name: user.displayName,
            avatarUrl: user.photoURL,
            radius: 20,
          ),
        );
      },
    );
  }
}

class _ProfileDialog extends StatelessWidget {
  const _ProfileDialog({
    required this.name,
    this.avatarUrl,
    required this.email,
  });

  final String name;
  final String? avatarUrl;
  final String email;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.7,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Vspace(8),
              Center(
                child: UserCircleAvatar(
                  name: name,
                  avatarUrl: avatarUrl,
                  radius: 44,
                ),
              ),
              const Vspace(8),
              Center(
                child: Text(
                  name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Center(
                child: Text(
                  email,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              Vspace(12),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.home_rounded),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  context.goNamed(AppRoutes.home);
                },
              ),

              ListTile(
                leading: const Icon(Icons.settings_rounded),
                title: const Text('Settings'),
                onTap: () {
                  SnackbarUtils.showErrorSnackbar(
                    context,
                    message: "Under development",
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text('Sign out'),
                onTap: () {
                  Navigator.pop(context);
                  context.read<AuthCubit>().logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
