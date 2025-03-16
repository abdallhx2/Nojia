import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nojia/services/Service_Stream.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CameraFeedWidget extends StatefulWidget {
  final bool isActive;

  const CameraFeedWidget({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  State<CameraFeedWidget> createState() => _CameraFeedWidgetState();
}

class _CameraFeedWidgetState extends State<CameraFeedWidget>
    with AutomaticKeepAliveClientMixin {
  final cameraService = CameraService();

  WebSocketChannel? _channel;
  bool _isConnected = false;
  bool _isLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (widget.isActive) _setupCamera();
  }

  @override
  void didUpdateWidget(CameraFeedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      widget.isActive ? _setupCamera() : _cleanup();
    }
  }

  Future<void> _setupCamera() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final isActive = await cameraService.getCameraStatus();
    if (!isActive) await cameraService.startCamera();
    final channel = await cameraService.connectWebSocket();

    if (mounted) {
      setState(() {
        _channel = channel;
        _isConnected = channel != null;
        _isLoading = false;
      });
    }

    if (channel == null && widget.isActive && mounted) {
      Future.delayed(const Duration(seconds: 5), _setupCamera);
    }
  }

  void _cleanup() {
    cameraService.disconnectWebSocket();
    setState(() {
      _channel = null;
      _isConnected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (!widget.isActive) return const SizedBox.shrink();
    if (_isLoading) return _buildLoadingState();

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 200,
        child: _isConnected && _channel != null
            ? _buildVideoStream()
            : _buildDisconnectedState(),
      ),
    );
  }

  Widget _buildVideoStream() {
    return StreamBuilder(
      stream: _channel!.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          try {
            final imageData = base64Decode(snapshot.data as String);
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.memory(
                  imageData,
                  gaplessPlayback: true,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'LIVE',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } catch (e) {
            return _buildErrorState('error decoding image: $e');
          }
        } else if (snapshot.hasError) {
          return _buildErrorState('error ${snapshot.error}');
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("connecting to camera..."),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
          ElevatedButton(
            onPressed: _setupCamera,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildDisconnectedState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, size: 48),
          const SizedBox(height: 8),
          const Text('camera disconnected'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _setupCamera,
            child: const Text('reconnect'),
          ),
        ],
      ),
    );
  }
}
