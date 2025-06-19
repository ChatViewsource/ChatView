import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image, video, audio, sticker, file }

class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String content;
  final Timestamp timestamp;
  final MessageType type;
  final bool isRead;
  final String? replyTo;
  final String? replyContent;
  final String? roomId;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.timestamp,
    this.type = MessageType.text,
    this.isRead = false,
    this.replyTo,
    this.replyContent,
    this.roomId,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Message(
      id: doc.id,
      senderId: data['senderId'],
      senderName: data['senderName'],
      content: data['content'],
      timestamp: data['timestamp'],
      type: MessageType.values[data['type']],
      isRead: data['isRead'] ?? false,
      replyTo: data['replyTo'],
      replyContent: data['replyContent'],
      roomId: data['roomId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'content': content,
      'timestamp': timestamp,
      'type': type.index,
      'isRead': isRead,
      'replyTo': replyTo,
      'replyContent': replyContent,
      'roomId': roomId,
    };
  }
}
