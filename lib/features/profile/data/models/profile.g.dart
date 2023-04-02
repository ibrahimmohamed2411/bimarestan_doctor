// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$$_ProfileFromJson(Map<String, dynamic> json) => _$_Profile(
      address: json['address'] as String,
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      image: json['image'] as String?,
      jobTitle: json['jobTitle'] as String?,
      id: json['id'] as int,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$$_ProfileToJson(_$_Profile instance) =>
    <String, dynamic>{
      'address': instance.address,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'email': instance.email,
      'fullName': instance.fullName,
      'image': instance.image,
      'jobTitle': instance.jobTitle,
      'id': instance.id,
      'phone': instance.phone,
    };
