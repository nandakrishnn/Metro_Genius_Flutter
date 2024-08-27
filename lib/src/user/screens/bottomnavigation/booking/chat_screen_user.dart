import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusapp/bloc/send_message_user/message_sending_bloc_bloc.dart';

class ChatScreenUser extends StatelessWidget {
  final String userId;
  final String workerId;

  String? chatId;
  String employename;
  ChatScreenUser({super.key, required this.userId, required this.workerId,required this.employename});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc()..add(LoadOrCreateChatRoom(userId, workerId)),
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatRoomReady) {
            context.read<ChatBloc>().add(LoadChatMessages(state.chatId));
            chatId = state.chatId;
          }
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return Scaffold(
              appBar: AppBar(title: Text('Worker')),
              body: const Center(child: CircularProgressIndicator()),
            );
          } else if (state is ChatLoaded) {
            return Scaffold(
              appBar: AppBar(
                title:  Text(employename),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: MessageList(messages: state.messages, workerId: workerId,userId: userId,eemployeName: employename,),
                  ),
                  _MessageInput(userId: userId, workerId: workerId, chatId: chatId!),
                ],
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(title: Text('Chat')),
              body: const Center(child: Text('Failed to load chat')),
            );
          }
        },
      ),
    );
  }
}

class MessageList extends StatefulWidget {
  final dynamic messages;
  final String workerId;
  final String userId;
  final String eemployeName;

  const MessageList({required this.messages, required this.workerId, required this.userId, required this.eemployeName});

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void didUpdateWidget(covariant MessageList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Scroll to bottom when new messages are added
    if (widget.messages.length != oldWidget.messages.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.messages.isEmpty){
      return Center(child: Text('Start a Conversion With\n''${widget.eemployeName}'),);
    }
    return ListView.builder(
      controller: _scrollController,
      reverse: false,
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        final message = widget.messages[index];
        final isWorkerMessage = message['senderId'] == widget.userId;

        // Convert the timestamp field correctly
        final timestamp = message['timestamp'];
        final messageTimestamp = timestamp is Timestamp
            ? timestamp.toDate()
            : DateTime.fromMillisecondsSinceEpoch(timestamp ?? 0);

        return Column(
          crossAxisAlignment: isWorkerMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: isWorkerMessage ? Colors.blueAccent : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: isWorkerMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      message['message'] ?? 'No message',
                      style: TextStyle(
                        color: isWorkerMessage ? Colors.white : Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      DateFormat('hh:mm a').format(messageTimestamp.toLocal()),
                      style: TextStyle(
                        color: isWorkerMessage ? Colors.white70 : Colors.black54,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


 class _MessageInput extends StatefulWidget {
  final String userId;
  final String workerId;
  final String chatId;

  const _MessageInput({required this.userId, required this.workerId, required this.chatId});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<_MessageInput> {
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
