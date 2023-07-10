import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'message.dart';

part 'conversation.g.dart';

@JsonSerializable(converters: [
  TimestampConverter(),
])
class Conversation {
  final String id;
  final String membersConcatenatedIds;
  final List<int> membersIds;
  final Message lastMessage;
  final List<Member> members;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const Conversation({
    required this.id,
    required this.membersConcatenatedIds,
    required this.membersIds,
    required this.lastMessage,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationToJson(this);

  String getOtherUserName(int userId, String userName) {
    final otherMember = members.firstWhere((element) => element.id != userId);
    return otherMember.name;
  }

  int getOtherUserId(int userId) {
    final otherMember = members.firstWhere((element) => element.id != userId);
    return otherMember.id;
  }
}

@JsonSerializable()
class Member {
  final int id;
  final String name;

  const Member({
    required this.id,
    required this.name,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
