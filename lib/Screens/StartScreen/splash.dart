import 'package:flutter/material.dart';
import 'package:nojia/Components/button.dart';
import 'package:nojia/constants.dart';
import 'package:nojia/route.dart';
import '../Authentication/login.dart';
import '../Authentication/register.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Najia',
      'description': 'Smart system for pool monitoring and drowning prevention',
      'image': AppImages.s1,
    },
    {
      'title': 'Continuous Monitoring',
      'description':
          'Smart monitoring system that sends immediate alerts when children approach the pool',
      'image': AppImages.s2,
    },
    {
      'title': 'Full Control',
      'description':
          'Complete system control and settings through an easy-to-use application',
      'image': AppImages.s3,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return SplashWidget(
                  title: _pages[index]['title']!,
                  description: _pages[index]['description']!,
                  image: _pages[index]['image']!,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? AppColors.primaryColor
                              : AppColors.textColor1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_currentPage < _pages.length - 1)
                  Button(
                    text: "Next",
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    backgroundColor: AppColors.primaryColor,
                    textColor: AppColors.textColor1,
                  )
                else
                  Column(
                    children: [
                      Button(
                        text: " Login",
                        onPressed: () {
                          AppNavigation.navigate(context, const Login());
                        },
                        backgroundColor: AppColors.primaryColor,
                        textColor: AppColors.textColor1,
                      ),
                      const SizedBox(height: 10),
                      Button(
                        text: " Create Account",
                        onPressed: () {
                          AppNavigation.navigate(context, const Register());
                        },
                        backgroundColor: AppColors.primaryColor,
                        textColor: AppColors.textColor1,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SplashWidget extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const SplashWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 350,
            height: 350,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
