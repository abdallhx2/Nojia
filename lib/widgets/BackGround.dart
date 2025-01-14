import 'package:flutter/material.dart';
import '../constants.dart';

class BackGround extends StatelessWidget {
  final Widget child;

  const BackGround({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.BackgroundColor,
              AppColors.BackgroundColor2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: child,
      ),
    );
  }
}
