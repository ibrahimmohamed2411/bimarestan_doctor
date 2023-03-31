// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequestModel _$SignUpRequestModelFromJson(Map<String, dynamic> json) =>
    SignUpRequestModel(
      address: json['address'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      fireBaseToken: json['fireBaseToken'] as String,
      password: json['password'] as String,
      roleId: json['roleId'] as int,
      categoryName: json['categoryName'] as String,
      categoryId: json['categoryId'] as int,
    );

Map<String, dynamic> _$SignUpRequestModelToJson(SignUpRequestModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'categoryId': instance.categoryId,
      'email': instance.email,
      'fireBaseToken': instance.fireBaseToken,
      'password': instance.password,
      'roleId': instance.roleId,
      'categoryName': instance.categoryName,
    };
