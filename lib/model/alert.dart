
import 'package:flutter/material.dart';

class AlertItem {
  final String title;
  final String time;
  final AlertType type;

  AlertItem({
    required this.title,
    required this.time,
    required this.type,
  });
}

enum AlertType {
  danger(
    icon: Icons.warning_amber_rounded,
    backgroundColor: Color(0xFFFFEBEE),
    iconColor: Colors.red,
  ),
  info(
    icon: Icons.info_outline,
    backgroundColor: Color(0xFFE3F2FD),
    iconColor: Colors.blue,
  ),
  success(
    icon: Icons.check_circle_outline,
    backgroundColor: Color(0xFFE8F5E9),
    iconColor: Colors.green,
  );

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const AlertType({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });
}
