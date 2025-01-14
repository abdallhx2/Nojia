import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nojia/Components/button.dart';
import 'package:nojia/Screens/StartScreen/ipCamera.dart';
import 'package:nojia/constants.dart';
import 'package:nojia/route.dart';

class Verification extends StatelessWidget {
  const Verification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Back button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => AppNavigation.back(
                    context,
                  ),
                ),
              ),
          
              // Logo
              Container(
                child: Column(
                  children: [
                    Image.asset(
                      AppImages.logo,
                      height: 120,
                    ),
                    const SizedBox(height: 10),
                   
                  ],
                ),
              ),
              SizedBox(height: 40),
          
              // Main content
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text(
                      "check it out!",
                      style: TextStyle(
                        fontSize: 40,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Enter your OTP sent to 05xxxxxxxx :",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 20),
          
                    // OTP Input Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        4,
                        (index) => SizedBox(
                          width: 50,
                          height: 50,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) {
                              if (value.length == 1 && index < 3) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
          
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive the verification code? ",
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle resend logic
                          },
                          child: const Text(
                            "Resend",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
          
                    Button(
                        text: "verification",
                        onPressed: () {
                          AppNavigation.navigate(context, IpCamera());
                        },
                        backgroundColor: AppColors.primaryColor,
                        textColor: AppColors.BackgroundColor2)
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
