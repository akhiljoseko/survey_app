import 'package:flutter/material.dart';
import 'package:school_surveys/view/home/widgets/user_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [UserButton()]),
      body: SafeArea(child: Center(child: Text("home"))),
    );
  }
}
