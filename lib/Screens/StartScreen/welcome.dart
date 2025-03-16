import 'package:flutter/material.dart';
import 'package:nojia/Components/button.dart';
import 'package:nojia/constants.dart';
import 'package:nojia/route.dart';
import 'package:nojia/providers/MainNavigation.dart';
import 'package:nojia/widgets/BackGround.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            Image.asset(
              AppImages.logo,
              width: 200,
              height: 200,
            ),
            const Text(
              "Nojia",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              ),
            ),
            const SizedBox(height: 20),
            Button(
                text: "Start",
                onPressed: () =>
                    AppNavigation.navigateReplace(context, const MainNavigation()),
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.BackgroundColor2)
          ],
        ),
      ),
    );
  }
}
