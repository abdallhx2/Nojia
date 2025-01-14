

import 'package:flutter/material.dart';

class AppNavigation {
 // للانتقال مع حذف الصفحة السابقة
 static void navigateReplace(BuildContext context, Widget screen) {
   Navigator.pushReplacement(
     context,
     MaterialPageRoute(builder: (context) => screen),
   );
 }

 // للانتقال مع إمكانية الرجوع
 static void navigate(BuildContext context, Widget screen) {
   Navigator.push(
     context,
     MaterialPageRoute(builder: (context) => screen),
   );
 }

 // للرجوع
 static void back(BuildContext context) {
   Navigator.pop(context);
 }
}