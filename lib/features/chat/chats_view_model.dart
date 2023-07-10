import 'package:bimarestan_doctors/features/chat/data/chat_api.dart';
import 'package:bimarestan_doctors/features/chat/models/conversation.dart';
import 'package:flutter/material.dart';

class ChatsViewModel extends ChangeNotifier {
  final ChatAPI _api = ChatAPI();
  late Stream<List<Conversation>> conversationsStream;
  late int userId;
  late String userName;

  Future<void> init(int userId, String userName) async {
    this.userId = userId;
    this.userName = userName;
    conversationsStream = _api.getConversationsStream(userId);
  }
}
