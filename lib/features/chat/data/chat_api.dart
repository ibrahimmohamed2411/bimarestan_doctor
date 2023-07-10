import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/conversation.dart';
import '../models/message.dart';

class ChatAPI {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Message> sendMessage({
    required String conversationId,
    required int senderId,
    required int recieverId,
    required String text,
    required List<String> images,
  }) async {
    final newDoc = _firestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .doc();
    await newDoc.set({
      'id': newDoc.id,
      'senderId': senderId,
      'recieverId': recieverId,
      'conversationId': conversationId,
      'text': text,
      'images': images,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return Message(
      id: newDoc.id,
      conversationId: conversationId,
      senderId: senderId,
      recieverId: recieverId,
      text: text,
      images: images,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Stream<List<Message>> getMessages(String conversationId) {
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

  Future<Conversation> getConversationIfNotCreateOne({
    required int doctorId,
    required int patientId,
    required String doctorName,
    required String patientName,
  }) async {
    final isExists = await isConversationExists(
      doctorId: doctorId,
      patientId: patientId,
    );
    if (isExists) {
      return getConversation(
        doctorId: doctorId,
        patientId: patientId,
      );
    } else {
      return createConversation(
        doctorId: doctorId,
        patientId: patientId,
        doctorName: doctorName,
        patientName: patientName,
      );
    }
  }

  Future<Conversation> getConversation({
    required int doctorId,
    required int patientId,
  }) async {
    final snapshot = await _firestore
        .collection('conversations')
        .where('membersIds', arrayContainsAny: [doctorId, patientId]).get();
    final doc = snapshot.docs.first;
    return Conversation(
      id: doc.id,
      membersIds: (doc.get('membersIds') as List<dynamic>)
          .map<int>((e) => e as int)
          .toList(),
      members: doc.get('members').map<Member>((e) {
        return Member(
          id: e['id'],
          name: e['name'],
        );
      }).toList(),
    );
  }

  Future<Conversation> createConversation({
    required int doctorId,
    required int patientId,
    required String doctorName,
    required String patientName,
  }) async {
    final newDoc = _firestore.collection('conversations').doc();

    await newDoc.set(
      {
        'id': newDoc.id,
        'membersIds': [doctorId, patientId],
        'members': [
          {
            'id': doctorId,
            'name': doctorName,
          },
          {
            'id': patientId,
            'name': patientName,
          },
        ],
      },
    );
    return Conversation(
      id: newDoc.id,
      membersIds: [doctorId, patientId],
      members: [
        Member(
          id: doctorId,
          name: doctorName,
        ),
        Member(
          id: patientId,
          name: patientName,
        ),
      ],
    );
  }

  Future<bool> isConversationExists({
    required int doctorId,
    required int patientId,
  }) {
    return _firestore
        .collection('conversations')
        .where('membersIds', arrayContainsAny: [doctorId, patientId])
        .get()
        .then((value) {
          return value.docs.isNotEmpty;
        });
  }
}
