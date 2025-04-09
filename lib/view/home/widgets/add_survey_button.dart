import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_surveys/app/routing/app_routes.dart';

class AddSurveyButton extends StatelessWidget {
  const AddSurveyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      onPressed: () {
        context.goNamed(AppRoutes.addSurvey);
      },
      label: Text("ADD SURVEY"),
      icon: Icon(Icons.add_rounded),
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        fixedSize: Size(double.maxFinite, 50),
      ),
    );
  }
}
