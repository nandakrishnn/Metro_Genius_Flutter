part of 'message_sending_bloc_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> messages;

  const ChatLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class ChatFailed extends ChatState {
  final String error;

  const ChatFailed(this.error);

  @override
  List<Object> get props => [error];
}
class ChatRoomReady extends ChatState {
  final String chatId;

  const ChatRoomReady(this.chatId);

  @override
  List<Object> get props=>[chatId];
}