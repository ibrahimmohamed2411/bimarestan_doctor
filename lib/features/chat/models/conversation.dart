import 'package:json_annotation/json_annotation.dart';

import 'message.dart';

part 'conversation.g.dart';

@JsonSerializable(converters: [
  TimestampConverter(),
])
class Conversation {
  final String id;
  final List<int> membersIds;
  final List<Member> members;

  const Conversation({
    required this.id,
    required this.membersIds,
    required this.members,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationToJson(this);
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
