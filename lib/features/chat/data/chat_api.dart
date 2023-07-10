import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/conversation.dart';
import '../models/message.dart';

class ChatAPI {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Message> sendMessage({
    required String? conversationId,
    required int senderId,
    required String senderName,
    required int recieverId,
    required String recieverName,
    required String text,
    required List<String> images,
  }) async {
    final conversationExsists = conversationId != null;
    final batch = _firestore.batch();
    if (conversationExsists) {
      return await _sendMessageAndUpdateLastConversationMessage(
        conversationId,
        senderId,
        recieverId,
        text,
        images,
        batch,
      );
    } else {
      return await _createConversationAndSendNewMessage(
        senderId,
        senderName,
        recieverId,
        recieverName,
        text,
        images,
        batch,
      );
    }
  }

  Future<Message> _createConversationAndSendNewMessage(
      int senderId,
      String senderName,
      int recieverId,
      String recieverName,
      String text,
      List<String> images,
      WriteBatch batch) async {
    final newConversationDoc = _firestore.collection('conversations').doc();
    final newMessageDoc = _firestore
        .collection('conversations')
        .doc(newConversationDoc.id)
        .collection('messages')
        .doc();
    final messageData = {
      'id': newMessageDoc.id,
      'senderId': senderId,
      'recieverId': recieverId,
      'conversationId': newConversationDoc.id,
      'text': text,
      'images': images,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    final conversationData = {
      'id': newConversationDoc.id,
      'membersConcatenatedIds': getConactenedId(
        senderId: senderId,
        recieverId: recieverId,
      ),
      'membersIds': [
        senderId,
        recieverId,
      ],
      'members': [
        {
          'id': senderId,
          'name': senderName,
        },
        {
          'id': recieverId,
          'name': recieverName,
        },
      ],
      'lastMessage': messageData,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    batch.set(newConversationDoc, conversationData);

    batch.set(newMessageDoc, messageData);
    await batch.commit();
    return Message(
      id: newMessageDoc.id,
      conversationId: newConversationDoc.id,
      senderId: senderId,
      recieverId: recieverId,
      text: text,
      images: images,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<Message> _sendMessageAndUpdateLastConversationMessage(
      String conversationId,
      int senderId,
      int recieverId,
      String text,
      List<String> images,
      WriteBatch batch) async {
    final messageDoc = _firestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .doc();
    final messagedata = {
      'id': messageDoc.id,
      'senderId': senderId,
      'recieverId': recieverId,
      'conversationId': conversationId,
      'text': text,
      'images': images,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    batch.set(messageDoc, messagedata);
    batch.update(
      _firestore.collection('conversations').doc(conversationId),
      {
        'lastMessage': messagedata,
        'updatedAt': FieldValue.serverTimestamp(),
      },
    );
    await batch.commit();
    return Message(
      id: messageDoc.id,
      conversationId: conversationId,
      senderId: senderId,
      recieverId: recieverId,
      text: text,
      images: images,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Stream<List<Message>> getMessagesStream(String conversationId) {
    log('getMessagesStream');
    log(conversationId);
    return _firestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return Message.fromJson(e.data());
      }).toList();
    });
  }

  Future<Conversation?> getConversation({
    required int doctorId,
    required int patientId,
  }) async {
    final snapshot = await _firestore
        .collection('conversations')
        .where(
          'membersConcatenatedIds',
          isEqualTo: getConactenedId(
            senderId: doctorId,
            recieverId: patientId,
          ),
        )
        .limit(1)
        .get();
    log(doctorId.toString());
    log(patientId.toString());
    final doc = snapshot.docs.isNotEmpty ? snapshot.docs.first : null;
    if (doc != null) {
      return Conversation.fromJson(doc.data());
    } else {
      return null;
    }
  }

  String getConactenedId({
    required int senderId,
    required int recieverId,
  }) {
    final ids = [senderId, recieverId];
    ids.sort();
    return ids.join('_');
  }

  Stream<List<Conversation>> getConversationsStream(int userId) {
    return _firestore
        .collection('conversations')
        .where('membersIds', arrayContains: userId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return Conversation.fromJson(e.data());
      }).toList();
    });
  }
}
