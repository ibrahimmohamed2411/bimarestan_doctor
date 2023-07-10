// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClinicModel _$ClinicModelFromJson(Map<String, dynamic> json) => ClinicModel(
      address: json['address'] as String,
      days: (json['days'] as List<dynamic>).map((e) => e as int).toList(),
      description: json['description'] as String,
      doctorId: json['doctorId'] as int,
      endWork: json['endWork'] as num,
      id: json['id'] as int?,
      name: json['name'] as String,
      phone: json['phone'] as String,
      startWork: json['startWork'] as num,
    );

Map<String, dynamic> _$ClinicModelToJson(ClinicModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'days': instance.days,
      'description': instance.description,
      'doctorId': instance.doctorId,
      'endWork': instance.endWork,
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'startWork': instance.startWork,
    };
