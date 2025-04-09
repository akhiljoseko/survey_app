import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_surveys/app/routing/app_routes.dart';
import 'package:school_surveys/view/home/widgets/user_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [UserButton()]),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoutes.addSurvey),
              child: Text("Add Survey"),
            ),
            Center(child: Text("home")),
          ],
        ),
      ),
    );
  }
}
