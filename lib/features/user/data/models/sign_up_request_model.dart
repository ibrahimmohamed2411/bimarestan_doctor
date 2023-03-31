import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_model.g.dart';

@JsonSerializable()
class SignUpRequestModel {
  final String address;
  final String name;
  final int categoryId;
  final String email;
  final String fireBaseToken;
  final String password;
  final int roleId;
  final String categoryName;
  SignUpRequestModel({
    required this.address,
    required this.name,
    required this.email,
    required this.fireBaseToken,
    required this.password,
    required this.roleId,
    required this.categoryName,
    required this.categoryId,
  });
  Map<String, dynamic> toJson() => _$SignUpRequestModelToJson(this);
  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestModelFromJson(json);
}
