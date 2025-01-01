//import 'package:flutter/material.dart';
// import 'package:nojia/Components/textfaild.dart';
// import 'package:nojia/Screens/Authentication/login.dart';
// import 'package:nojia/constants.dart';
// import 'package:nojia/widget/button.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class Register extends StatefulWidget {
//   const Register({Key? key}) : super(key: key);

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final _formKey = GlobalKey<FormState>();
//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//   bool _isLoading = false;

//   // Controllers
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _phoneController.dispose();
//     _dobController.dispose();
//     super.dispose();
//   }

//   // Validation Functions
//   String? _validateName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'This field is required';
//     }
//     if (value.length < 2) {
//       return 'Name must be at least 2 characters';
//     }
//     return null;
//   }

//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email is required';
//     }
//     final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     if (!emailRegExp.hasMatch(value)) {
//       return 'Please enter a valid email';
//     }
//     return null;
//   }

//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password is required';
//     }
//     if (value.length < 6) {
//       return 'Password must be at least 6 characters';
//     }
//     return null;
//   }

//   String? _validateConfirmPassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please confirm your password';
//     }
//     if (value != _passwordController.text) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   String? _validatePhone(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Phone number is required';
//     }
//     final phoneRegExp = RegExp(r'^05\d{8}$');
//     if (!phoneRegExp.hasMatch(value)) {
//       return 'Please enter a valid phone number (05xxxxxxxx)';
//     }
//     return null;
//   }

//   // API Call Function
//   Future<void> _register() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final response = await http.post(
//         Uri.parse('YOUR_API_ENDPOINT/register'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'firstName': _firstNameController.text,
//           'lastName': _lastNameController.text,
//           'email': _emailController.text,
//           'password': _passwordController.text,
//           'phone': _phoneController.text,
//           'dateOfBirth': _dobController.text,
//         }),
//       );

//       if (response.statusCode == 201) {
//         // Registration successful
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Registration successful!'),
//               backgroundColor: Colors.green,
//             ),
//           );
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const Login()),
//           );
//         }
//       } else {
//         // Registration failed
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(json.decode(response.body)['message'] ??
//                   'Registration failed'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('An error occurred. Please try again.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 20),

//                   // Logo and Title
//                   Center(
//                     child: Column(
//                       children: [
//                         Image.asset(
//                           AppImages.logo,
//                           height: 100,
//                         ),
//                         const SizedBox(height: 24),
//                         const Text(
//                           "Let's get to know you",
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 32),

//                   // Form Container
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 15,
//                           offset: const Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         // First Name and Last Name Row
//                         Row(
//                           children: [
//                             Expanded(
//                               child: CustomTextField(
//                                 label: 'First Name',
//                                 hint: 'Enter first name',
//                                 controller: _firstNameController,
//                                 validator: _validateName,
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: CustomTextField(
//                                 label: 'Last Name',
//                                 hint: 'Enter last name',
//                                 controller: _lastNameController,
//                                 validator: _validateName,
//                               ),
//                             ),
//                           ],
//                         ),

//                         CustomTextField(
//                           label: 'Email',
//                           hint: 'Enter your email',
//                           keyboardType: TextInputType.emailAddress,
//                           controller: _emailController,
//                           validator: _validateEmail,
//                         ),

//                         CustomTextField(
//                           label: 'Password',
//                           hint: 'Create password',
//                           isPassword: true,
//                           isVisible: _isPasswordVisible,
//                           controller: _passwordController,
//                           validator: _validatePassword,
//                           onVisibilityToggle: () {
//                             setState(() {
//                               _isPasswordVisible = !_isPasswordVisible;
//                             });
//                           },
//                         ),

//                         CustomTextField(
//                           label: 'Re-enter Password',
//                           hint: 'Re-enter password',
//                           isPassword: true,
//                           isVisible: _isConfirmPasswordVisible,
//                           controller: _confirmPasswordController,
//                           validator: _validateConfirmPassword,
//                           onVisibilityToggle: () {
//                             setState(() {
//                               _isConfirmPasswordVisible =
//                                   !_isConfirmPasswordVisible;
//                             });
//                           },
//                         ),

//                         CustomTextField(
//                           label: 'Phone number',
//                           hint: '05xxxxxxxx',
//                           keyboardType: TextInputType.phone,
//                           controller: _phoneController,
//                           validator: _validatePhone,
//                         ),

//                         const SizedBox(height: 24),

//                         _isLoading
//                             ? const CircularProgressIndicator()
//                             : Button(
//                                 text: 'Create Account',
//                                 onPressed: _register,
//                                 backgroundColor: AppColors.primaryColor,
//                                 textColor: Colors.white,
//                                 width: double.infinity,
//                               ),

//                         const SizedBox(height: 20),

//                         // Login Link
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Already have an account? ',
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 16,
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const Login(),
//                                   ),
//                                 );
//                               },
//                               child: const Text(
//                                 'Login',
//                                 style: TextStyle(
//                                   color: AppColors.primaryColor,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
