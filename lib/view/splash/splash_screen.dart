import 'package:flutter/material.dart';
import 'package:school_surveys/app/app_images.dart';
import 'package:school_surveys/view/widgets/spacing.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.logo,
              width: size.width / 2,
              height: size.height / 3,
            ),
            Vspace(16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
