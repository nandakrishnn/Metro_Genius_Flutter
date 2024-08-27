import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatServices {
  static Stream<QuerySnapshot<Map<String, dynamic>>> loadChatMessages(String chatId) {
    return FirebaseFirestore.instance.collection('chatRooms').doc(chatId).collection('messages').orderBy('timestamp').snapshots();
  }

  static Future<bool> userSendMessage(String userId, String message, String chatId) async {
    try {
      await FirebaseFirestore.instance.collection('chatRooms').doc(chatId).collection('messages').add({
        'senderId': userId,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
      debugPrint('Message sent successfully');
      return true;
    } catch (e) {
      debugPrint('Failed to send message: $e');
      return false;
    }
  }

   static Future<bool> workerSendMessage(String workerId, String message, String chatId) async {
    try {
      await FirebaseFirestore.instance.collection('chatRooms').doc(chatId).collection('messages').add({
        'senderId': workerId,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
      debugPrint('Message sent successfully');
      return true;
    } catch (e) {
      debugPrint('Failed to send message: $e');
      return false;
    }
  }

  static Future<String> getOrCreateChatRoom(String userId, String workerId) async {
    try {
      final chatRoomsRef = FirebaseFirestore.instance.collection('chatRooms');
      final querySnapshot = await chatRoomsRef.where('participants', arrayContains: userId).get();

      String? chatId;
      for (var doc in querySnapshot.docs) {
        final participants = doc.data()['participants'] as List<dynamic>;
        if (participants.contains(workerId)) {
          chatId = doc.id;
          break;
        }
      }

      if (chatId == null) {
        final newChatRoomRef = await chatRoomsRef.add({
          'participants': [userId, workerId],
          'createdAt': FieldValue.serverTimestamp(),
        });
        chatId = newChatRoomRef.id;
      }

      return chatId;
    } catch (e) {
      debugPrint('Failed to get or create chat room: $e');
      return '';
    }
  }
}