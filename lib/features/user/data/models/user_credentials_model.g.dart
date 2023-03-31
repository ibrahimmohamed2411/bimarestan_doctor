// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credentials_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCredentialsModel _$UserCredentialsModelFromJson(
        Map<String, dynamic> json) =>
    UserCredentialsModel(
      address: json['address'] as String,
      age: json['age'] as int,
      categoryId: json['categoryId'] as int?,
      categoryName: json['categoryName'] as String?,
      clinicId: json['clinicId'] as int?,
      clinicName: json['clinicName'] as String?,
      description: json['description'] as String,
      email: json['email'] as String,
      fireBaseToken: json['fireBaseToken'] as String,
      fireBaseWebToken: json['fireBaseWebToken'] as String,
      fullName: json['fullName'] as String,
      id: json['id'] as int,
      image: json['image'] as String,
      jobTitle: json['jobTitle'] as String,
      phone: json['phone'] as String,
      roleId: json['roleId'] as int,
      roleName: json['roleName'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserCredentialsModelToJson(
        UserCredentialsModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'age': instance.age,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'clinicId': instance.clinicId,
      'clinicName': instance.clinicName,
      'description': instance.description,
      'email': instance.email,
      'fireBaseToken': instance.fireBaseToken,
      'fireBaseWebToken': instance.fireBaseWebToken,
      'fullName': instance.fullName,
      'id': instance.id,
      'image': instance.image,
      'jobTitle': instance.jobTitle,
      'phone': instance.phone,
      'roleId': instance.roleId,
      'roleName': instance.roleName,
      'token': instance.token,
    };
