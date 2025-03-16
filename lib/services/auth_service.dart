import 'package:flutter/material.dart';
import 'package:nojia/Components/SnackBar.dart';
import 'package:nojia/Screens/Authentication/login.dart';
import 'package:nojia/providers/AuthProvider.dart';
import 'package:nojia/providers/MainNavigation.dart';
import 'package:nojia/route.dart';
import 'package:provider/provider.dart';

class AuthServices {
  static Future<void> handleSignUp(
    BuildContext context, {
    required TextEditingController fnameController,
    required TextEditingController lnameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
    required TextEditingController phoneController,
  }) async {
    if (passwordController.text != confirmPasswordController.text) {
      context.showErrorSnackBar('Passwords do not match');
      return;
    }

    if (passwordController.text.length < 6) {
      context.showErrorSnackBar('Password must be at least 6 characters');
      return;
    }

    if (phoneController.text.length < 10) {
      context.showErrorSnackBar('Phone number must be at least 10 characters');
      return;
    }

    if (fnameController.text.isEmpty ||
        lnameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      context.showErrorSnackBar('Please fill all fields');
      return;
    }

    try {
      context.showLoadingSnackBar('Creating account...');

      await context.read<AuthProvider>().signUp(
            fnameController.text.trim(),
            lnameController.text.trim(),
            emailController.text.trim(),
            passwordController.text,
            phoneController.text.trim(),
          );

      context.showSuccessSnackBar(
        'Account created successfully! Please login',
      );

      await Future.delayed(const Duration(seconds: 1));
      AppNavigation.navigate(context, const Login());
    } catch (e) {
      context.showErrorSnackBar(e.toString());
    }
  }

  static Future<void> handleSignIn(
    BuildContext context, {
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      context.showErrorSnackBar('Please fill all fields');
      return;
    }

    try {
      context.showLoadingSnackBar('Signing in...');

      String? error = await context.read<AuthProvider>().signIn(
            emailController.text.trim(),
            passwordController.text,
          );

      if (error != null) {
        context.showErrorSnackBar(error);
        return;
      }

      context.showSuccessSnackBar('Signed in successfully!');

      await Future.delayed(const Duration(seconds: 1));
      AppNavigation.navigate(context, const MainNavigation());
    } catch (e) {
      context.showErrorSnackBar(e.toString());
    }
  }
}
