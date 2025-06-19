import 'package:flutter/material.dart';
import 'package:chatview/models/message.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool showSender;

  const MessageBubble({
    required this.message,
    this.showSender = true,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isMe 
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showSender && !message.isMe)
              Text(
                message.senderId,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            SizedBox(height: 4),
            _buildContent(context),
            SizedBox(height: 4),
            Text(
              DateFormat('HH:mm').format(message.timestamp),
              style: TextStyle(
                fontSize: 10,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (message.type) {
      case MessageType.image:
        return Image.network(message.content);
      case MessageType.video:
        return Text('[Video] ${message.content}');
      case MessageType.audio:
        return Text('[Audio]');
      case MessageType.sticker:
        return Text('[Sticker]');
      default:
        return Text(
          message.content,
          style: TextStyle(color: AppColors.textPrimary),
        );
    }
  }
}
