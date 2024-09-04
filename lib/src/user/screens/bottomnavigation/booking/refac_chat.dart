
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusapp/bloc/send_message_user/message_sending_bloc_bloc.dart';



 class MessageInput extends StatefulWidget {
  final String userId;
  final String workerId;
  final String chatId;

  const MessageInput({required this.userId, required this.workerId, required this.chatId});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                BlocProvider.of<ChatBloc>(context).add(UserSendMessage(
                  userId: widget.userId,
                  message: _controller.text,
                  chatId: widget.chatId,
                ));
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
