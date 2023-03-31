import 'package:json_annotation/json_annotation.dart';

part 'user_credentials_model.g.dart';

@JsonSerializable()
class UserCredentialsModel {
  final String address;
  final int age;
  final int? categoryId;
  final String? categoryName;
  final int? clinicId;
  final String? clinicName;
  final String description;
  final String email;
  final String fireBaseToken;
  final String fireBaseWebToken;
  final String fullName;
  final int id;
  final String image;
  final String jobTitle;

  final String phone;
  final int roleId;
  final String roleName;
  final String token;
  UserCredentialsModel({
    required this.address,
    required this.age,
    this.categoryId,
    this.categoryName,
    this.clinicId,
    this.clinicName,
    required this.description,
    required this.email,
    required this.fireBaseToken,
    required this.fireBaseWebToken,
    required this.fullName,
    required this.id,
    required this.image,
    required this.jobTitle,
    required this.phone,
    required this.roleId,
    required this.roleName,
    required this.token,
  });
  Map<String, dynamic> toJson() => _$UserCredentialsModelToJson(this);
  factory UserCredentialsModel.fromJson(Map<String, dynamic> json) =>
      _$UserCredentialsModelFromJson(json);
}
