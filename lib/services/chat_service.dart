import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:chatview/models/message.dart';

class ChatService extends ChangeNotifier {
  late IO.Socket _socket;
  List<Message> _messages = [];
  bool _isConnected = false;

  List<Message> get messages => _messages;
  bool get isConnected => _isConnected;

  void connect(String userId) {
    _socket = IO.io('https://api.chatview.app', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'userId': userId},
    });

    _socket.connect();

    _socket.on('connect', (_) {
      _isConnected = true;
      notifyListeners();
    });

    _socket.on('new_message', (data) {
      final message = Message.fromJson(data);
      _messages.insert(0, message);
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _isConnected = false;
      notifyListeners();
    });
  }

  void sendMessage(Message message) {
    _socket.emit('send_message', {
      'id': message.id,
      'senderId': message.senderId,
      'content': message.content,
      'timestamp': message.timestamp.toIso8601String(),
      'type': message.type.index,
      'replyTo': message.replyTo,
    });
  }

  void disconnect() {
    _socket.disconnect();
  }

  @override
  void dispose() {
    _socket.dispose();
    super.dispose();
  }
}
