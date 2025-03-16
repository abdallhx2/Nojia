import 'package:flutter/material.dart';
import 'package:nojia/constants.dart';
import 'package:nojia/model/alert.dart';
import 'package:nojia/services/notifications_service.dart';

class AlertsSectionWidget extends StatelessWidget {
  final NotificationsService notificationsService;
  final bool isExpanded;
  final VoidCallback onExpandToggle;

  const AlertsSectionWidget({
    required this.notificationsService,
    required this.isExpanded,
    required this.onExpandToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _buildStyledContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(),
          const SizedBox(height: 12),
          _buildAlertsSection(),
        ],
      ),
    );
  }

  Widget _buildStyledContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: child,
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Notifications and Alerts',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        IconButton(
          icon: Icon(
            isExpanded ? Icons.expand_less : Icons.expand_more,
            color: AppColors.primaryColor,
          ),
          onPressed: onExpandToggle,
        ),
      ],
    );
  }

  Widget _buildAlertsSection() {
    return StreamBuilder<List<AlertItem>>(
      stream: notificationsService.streamAlerts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildStatusMessage('Error loading alerts', isError: true);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final alerts = snapshot.data ?? [];
        if (alerts.isEmpty) {
          return _buildStatusMessage('No alerts available');
        }

        return AnimatedCrossFade(
          firstChild: Column(children: [_buildAlertItem(alerts.first)]),
          secondChild: Column(children: alerts.map(_buildAlertItem).toList()),
          crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }

  Widget _buildAlertItem(AlertItem alert) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: alert.type.backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(alert.type.icon, color: alert.type.iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  alert.time,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusMessage(String text, {bool isError = false}) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: isError ? Colors.red[400] : Colors.black,
        ),
      ),
    );
  }
}