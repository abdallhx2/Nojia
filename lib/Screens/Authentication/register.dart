import 'package:flutter/material.dart';
import 'package:nojia/Components/button.dart';
import 'package:nojia/Components/textfaild.dart';
import 'package:nojia/constants.dart';
import 'package:nojia/providers/AuthProvider.dart';
import 'package:nojia/route.dart';
import 'package:nojia/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _fnameController.dispose();
    _lnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          AppImages.logo,
                          height: 80,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Let's get to know you",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primaryColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: _fnameController,
                                label: 'First Name',
                                hint: 'Enter first name',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomTextField(
                                controller: _lnameController,
                                label: 'Last Name',
                                hint: 'Enter last name',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _emailController,
                          label: 'Email',
                          hint: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          label: 'Password',
                          hint: 'Create password',
                          isPassword: true,
                          isVisible: _isPasswordVisible,
                          onVisibilityToggle: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          label: 'Re-enter Password',
                          hint: 'Re-enter password',
                          isPassword: true,
                          isVisible: _isConfirmPasswordVisible,
                          onVisibilityToggle: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _phoneController,
                          label: 'Phone number',
                          hint: '05xxxxxxxx',
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 15),
                        Button(
                          text: 'Create Account',
                          onPressed: () {
                            AuthServices.handleSignUp(
                              context,
                              fnameController: _fnameController,
                              lnameController: _lnameController,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              confirmPasswordController:
                                  _confirmPasswordController,
                              phoneController: _phoneController,
                            );
                          },
                          backgroundColor: AppColors.primaryColor,
                          textColor: Colors.white,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account? ',
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextButton(
                                onPressed: () {
                                  AppNavigation.navigate(
                                      context, const Login());
                                },
                                child: const Text(
                                  'Login',
                                  style:
                                      TextStyle(color: AppColors.primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
