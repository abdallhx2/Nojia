import 'package:flutter/material.dart';
import 'package:nojia/constants.dart';
import 'package:nojia/model/alert.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Sample data - replace with your actual data source
  final List<AlertItem> alerts = [
    AlertItem(
      title: "Your child is in danger",
      time: "1 hour ago",
      type: AlertType.danger,
    ),
    AlertItem(
      title: "There is a child in the pool area",
      time: "2 minutes ago",
      type: AlertType.info,
    ),
    AlertItem(
      title: "There is a child in the pool area",
      time: "2 minutes ago",
      type: AlertType.info,
    ),
    AlertItem(
      title: "look out !",
      time: "2 minutes ago",
      type: AlertType.info,
    ),
    AlertItem(
      title: "Start Detection",
      time: "3 hours ago",
      type: AlertType.success,
    ),
  ];

  void _removeAlert(int index) {
    setState(() {
      alerts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: alerts.isEmpty
          ? const Center(
              child: Text(
                'No notifications',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                final alert = alerts[index];
                return Dismissible(
                  key: Key(alert.title + index.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) => _removeAlert(index),
                  child: Card(
                    color: AppColors.BackgroundColor2,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: alert.type.backgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          alert.type.icon,
                          color: alert.type.iconColor,
                        ),
                      ),
                      title: Text(
                        alert.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(alert.time),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
