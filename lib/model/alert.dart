
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class AlertItem {
  final String title;
  final String time;
  final AlertType type;
  final String id;

  AlertItem({
    required this.title,
    required this.time,
    required this.type,
    required this.id,
  });

  factory AlertItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AlertItem(
      id: doc.id,
      title: data['title'] ?? '',
      time: _formatTimestamp(data['timestamp'] as Timestamp),
      type: _getAlertTypeFromString(data['type'] as String),
    );
  }

  static String _formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  static AlertType _getAlertTypeFromString(String type) {
    return switch (type.toLowerCase()) {
      'danger' => AlertType.danger,
      'success' => AlertType.success,
      _ => AlertType.info,
    };
  }
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
