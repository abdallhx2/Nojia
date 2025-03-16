import 'package:flutter/material.dart';
import 'package:nojia/Screens/MainScreen/Home/alert.dart';
import 'package:nojia/Screens/MainScreen/Home/displyCam.dart';
import 'package:nojia/constants.dart';
import 'package:nojia/services/notifications_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  bool isExpanded = false;
  final NotificationsService _notificationsService = NotificationsService();

  @override
  bool get wantKeepAlive => true; // Keep the state alive when navigating

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, AppColors.BackgroundColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView(
        children: [
          _buildHeader(),
          CameraFeedWidget(
            isActive: true,
          ),
          AlertsSectionWidget(
            notificationsService: _notificationsService,
            isExpanded: isExpanded,
            onExpandToggle: () => setState(() => isExpanded = !isExpanded),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.logo, height: 40),
          const SizedBox(width: 8),
          const Text(
            'نجية',
            style: TextStyle(
              fontSize: 20,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}















// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:nojia/constants.dart';
// import 'package:nojia/model/alert.dart';
// import 'package:nojia/services/notifications_service.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'dart:convert';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool isExpanded = false;
//   final NotificationsService _notificationsService = NotificationsService();
//   late WebSocketChannel channel;
//   bool isConnected = false;

//   @override
//   void initState() {
//     super.initState();
//     connectToServer();
//   }


//   void connectToServer() {
//     try {
//       channel = WebSocketChannel.connect(
//         Uri.parse('ws://192.168.8.129:8000/ws'),
//       );
//       setState(() {
//         isConnected = true;
//       });
//     } catch (e) {
//       print('Connection error: $e');
//       setState(() {
//         isConnected = false;
//       });
//       Future.delayed(Duration(seconds: 5), connectToServer);
//     }
//   }

//   Widget _buildStyledContainer(
//       {required Widget child, EdgeInsetsGeometry? margin}) {
//     return Container(
//       margin: margin ?? const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.withOpacity(0.2)),
//       ),
//       child: child,
//     );
//   }

//   Widget _buildSectionHeader(String title, VoidCallback onPressed) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: AppColors.primaryColor,
//           ),
//         ),
//         IconButton(
//           icon: Icon(
//             isExpanded ? Icons.expand_less : Icons.expand_more,
//             color: AppColors.primaryColor,
//           ),
//           onPressed: onPressed,
//         ),
//       ],
//     );
//   }

//   Widget _buildAlertItem(AlertItem alert) {
//     return _buildStyledContainer(
//       margin: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: alert.type.backgroundColor,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(alert.type.icon, color: alert.type.iconColor, size: 20),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(alert.title,
//                     style: const TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.w500)),
//                 Text(alert.time,
//                     style: TextStyle(fontSize: 12, color: Colors.grey[600])),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAlertsSection() {
//     return StreamBuilder<List<AlertItem>>(
//       stream: _notificationsService.streamAlerts(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError)
//           return _buildStatusMessage('Error loading alerts', isError: true);
//         if (snapshot.connectionState == ConnectionState.waiting)
//           return const Center(child: CircularProgressIndicator());

//         final alerts = snapshot.data ?? [];
//         if (alerts.isEmpty) return _buildStatusMessage('No alerts available');

//         return AnimatedCrossFade(
//           firstChild: Column(children: [_buildAlertItem(alerts.first)]),
//           secondChild: Column(children: alerts.map(_buildAlertItem).toList()),
//           crossFadeState:
//               isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
//           duration: const Duration(milliseconds: 300),
//         );
//       },
//     );
//   }

//   Widget _buildStatusMessage(String text, {bool isError = false}) {
//     return Center(
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: 16,
//           color: isError ? Colors.red[400] : Colors.black,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.white, AppColors.BackgroundColor],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: ListView(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(AppImages.logo, height: 40),
//                 const SizedBox(width: 8),
//                 const Text('نجية',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: AppColors.primaryColor,
//                       fontWeight: FontWeight.bold,
//                     )),
//               ],
//             ),
//           ),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: Container(
//               height: 200, // Adjust height as needed
//               child: isConnected
//                   ? StreamBuilder(
//                       stream: channel.stream,
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           try {
//                             final imageData =
//                                 base64Decode(snapshot.data as String);
//                             return Image.memory(
//                               imageData,
//                               gaplessPlayback: true,
//                               fit: BoxFit.cover,
//                             );
//                           } catch (e) {
//                             return Center(
//                               child: Text('Error decoding image: $e'),
//                             );
//                           }
//                         } else if (snapshot.hasError) {
//                           return Center(
//                             child: Text('Error: ${snapshot.error}'),
//                           );
//                         }
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       },
//                     )
//                   : Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.wifi_off, size: 48),
//                           SizedBox(height: 8),
//                           Text('Connecting to camera...'),
//                         ],
//                       ),
//                     ),
//             ),
//           ),
//           _buildStyledContainer(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildSectionHeader('Notifications and Alerts',
//                     () => setState(() => isExpanded = !isExpanded)),
//                 const SizedBox(height: 12),
//                 _buildAlertsSection(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
