enum MessageType { text, image, video, audio, sticker }

class Message {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final bool isMe;
  final String? replyTo;

  Message({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    this.type = MessageType.text,
    this.isMe = false,
    this.replyTo,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderId: json['senderId'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      type: MessageType.values[json['type']],
      isMe: json['isMe'],
      replyTo: json['replyTo'],
    );
  }
}
