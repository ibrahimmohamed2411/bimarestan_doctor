import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp json) {
    return json.toDate();
  }

  @override
  Timestamp toJson(DateTime object) {
    return Timestamp.fromDate(object);
  }
}

@JsonSerializable(
  converters: [
    TimestampConverter(),
  ],
)
class Message {
  final String id;
  final String conversationId;
  final int senderId;
  final int recieverId;
  final String text;
  @JsonKey(defaultValue: [])
  final List<String> images;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.recieverId,
    required this.text,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
