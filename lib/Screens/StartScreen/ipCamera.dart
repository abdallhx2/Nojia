import 'package:flutter/material.dart';
import 'package:nojia/Components/button.dart';
import 'package:nojia/Components/textfaild.dart';
import 'package:nojia/Screens/StartScreen/welcome.dart';
import 'package:nojia/constants.dart';
import 'package:nojia/route.dart';

class IpCamera extends StatelessWidget {
  const IpCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Logo and Title
              const SizedBox(height: 60),
              Container(
                child: const Text(
                  "IP address connected\nto the camer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Camera Connection Illustration
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Image.asset(
                  AppImages.cam,
                ),
              ),

              const SizedBox(height: 40),

              // IP Address Input
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField(
                  label: 'IP Address',
                  hint: 'Enter your IP address',
                  keyboardType: TextInputType.phone,
                ),
              ),

              const SizedBox(height: 40),

              // Connect Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Button(
                  text: "Check",
                  onPressed: () {
                    AppNavigation.navigate(context, const WelcomeScreen());
                  },
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.BackgroundColor2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
