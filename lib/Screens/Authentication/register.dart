import 'package:flutter/material.dart';
import 'package:nojia/Components/textfaild.dart';
import 'package:nojia/Screens/Authentication/login.dart';
import 'package:nojia/constants.dart';
import 'package:nojia/widget/button.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo and Title
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

              // Form Container
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
                    // First Name and Last Name Row
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'First Name',
                            hint: 'Enter first name',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            label: 'Last Name',
                            hint: 'Enter last name',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    CustomTextField(
                      label: 'Email',
                      hint: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),

                    CustomTextField(
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
                      label: 'Phone number',
                      hint: '05xxxxxxxx',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 10),

                    CustomTextField(
                      label: 'Date of Birth',
                      hint: 'mm/dd/yyyy',
                      keyboardType: TextInputType.datetime,
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 15),

                    Button(
                      text: 'Create Account',
                      onPressed: () {},
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(color: AppColors.primaryColor),
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
      ),
    );
  }
}



// 