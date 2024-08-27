part of 'message_sending_bloc_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadChatMessages extends ChatEvent {
  final String chatId;

  const LoadChatMessages(this.chatId);

  @override
  List<Object> get props => [chatId];
}

class DataFetched extends ChatEvent {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> data;

  const DataFetched(this.data);

  @override
  List<Object> get props => [data];
}

class UserSendMessage extends ChatEvent {
  final String chatId;
  final String userId;
  final String message;

  const UserSendMessage({required this.chatId, required this.userId, required this.message});

  @override
  List<Object> get props => [chatId, userId, message];
}
class WorkerSendMessage extends ChatEvent {
  final String chatId;
  final String workerId;
  final String message;

  const WorkerSendMessage({required this.chatId, required this.workerId, required this.message});

  @override
  List<Object> get props => [chatId, workerId, message];
}
class LoadOrCreateChatRoom extends ChatEvent {
  final String userId;
  final String workerId;

  const LoadOrCreateChatRoom(this.userId, this.workerId);

  @override
  List<Object> get props => [userId,workerId];
}