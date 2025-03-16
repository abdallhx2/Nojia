import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class CameraService {
  final String baseUrl;
  WebSocketChannel? _channel;
  
  CameraService({this.baseUrl = 'http://192.168.8.129:8000'});
  
  Future<bool> getCameraStatus() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/camera/status'));
      return response.statusCode == 200 && 
             (jsonDecode(response.body)['active'] ?? false);
    } catch (e) {
      print('Error checking camera status: $e');
      return false;
    }
  }

  Future<bool> startCamera() async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/camera/start'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error starting camera: $e');
      return false;
    }
  }

  Future<bool> stopCamera() async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/camera/stop'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error stopping camera: $e');
      return false;
    }
  }
  
  Future<WebSocketChannel?> connectWebSocket() async {
    try {
      final wsUrl = baseUrl.replaceFirst('http', 'ws');
      _channel = WebSocketChannel.connect(Uri.parse('$wsUrl/ws'));
      return _channel;
    } catch (e) {
      print('WebSocket connection error: $e');
      return null;
    }
  }
  
  void disconnectWebSocket() {
    _channel?.sink.close();
    _channel = null;
  }
}