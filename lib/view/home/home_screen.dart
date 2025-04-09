import 'package:flutter/material.dart';
import 'package:school_surveys/view/home/widgets/add_survey_button.dart';
import 'package:school_surveys/view/home/widgets/user_button.dart';
import 'package:school_surveys/view/widgets/spacing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Dashboard",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [UserButton()],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ScreenPadding(
            child: Column(children: [Vspace(12), AddSurveyButton()]),
          ),
        ),
      ),
    );
  }
}
