import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusapp/services/chat/chat_services.dart';

part 'message_sending_bloc_event.dart';
part 'message_sending_bloc_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<LoadOrCreateChatRoom>(_onLoadOrCreateChatRoom);
    on<LoadChatMessages>(_onLoadChatMessages);
    on<DataFetched>(_onDataFetched);
    on<UserSendMessage>(_onUserSendMessage);
    on<WorkerSendMessage>(_onWorkerSendMessage);
  }
  @override
  Future<void> close() {
    // Cleanup any resources here
    return super.close();
  }

  Future<void> _onLoadOrCreateChatRoom(LoadOrCreateChatRoom event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      final chatId = await ChatServices.getOrCreateChatRoom(event.userId, event.workerId);
      emit(ChatRoomReady(chatId));
    } catch (e) {
      emit(ChatFailed(e.toString()));
    }
  }

  void _onLoadChatMessages(LoadChatMessages event, Emitter<ChatState> emit) {
    if (isClosed) return;
    emit(ChatLoading());
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> messageStream = ChatServices.loadChatMessages(event.chatId);

      messageStream.listen((snapshot) {
        final data = snapshot.docs;
        add(DataFetched(data));
      });
    } catch (e) {
      emit(ChatFailed(e.toString()));
    }
  }

  void _onDataFetched(DataFetched event, Emitter<ChatState> emit) {
    emit(ChatLoaded(event.data));
  }

  Future<void> _onUserSendMessage(UserSendMessage event, Emitter<ChatState> emit) async {
    try {
      await ChatServices.userSendMessage(event.userId, event.message, event.chatId);
    } catch (e) {
      emit(ChatFailed(e.toString()));
    }
  }

  Future<void> _onWorkerSendMessage(WorkerSendMessage event, Emitter<ChatState> emit) async {
    try {
      await ChatServices.workerSendMessage(event.workerId, event.message, event.chatId);
    } catch (e) {
      emit(ChatFailed(e.toString()));
}
}
}