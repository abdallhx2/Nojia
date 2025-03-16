

import 'package:flutter/material.dart';

class AppNavigation {

 static void navigateReplace(BuildContext context, Widget screen) {
   Navigator.pushReplacement(
     context,
     MaterialPageRoute(builder: (context) => screen),
   );
 }
 static void navigate(BuildContext context, Widget screen) {
   Navigator.push(
     context,
     MaterialPageRoute(builder: (context) => screen),
   );
 }
 static void back(BuildContext context) {
   Navigator.pop(context);
 }
}