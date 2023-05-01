// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      appointmentDate: DateTime.parse(json['appointmentDate'] as String),
      cancelled: json['cancelled'] as bool,
      clinicId: json['clinicId'] as int,
      finish: json['finish'] as bool,
      id: json['id'] as int,
      numPatient: json['numPatient'] as int,
      patientFullName: json['patientFullName'] as String,
      patientId: json['patientId'] as int,
      patientPhone: json['patientPhone'] as String,
      price: json['price'] as int,
      priceId: json['priceId'] as int,
      priceName: json['priceName'] as String,
      time: json['time'] as int,
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'appointmentDate': instance.appointmentDate.toIso8601String(),
      'cancelled': instance.cancelled,
      'clinicId': instance.clinicId,
      'finish': instance.finish,
      'id': instance.id,
      'numPatient': instance.numPatient,
      'patientFullName': instance.patientFullName,
      'patientId': instance.patientId,
      'patientPhone': instance.patientPhone,
      'price': instance.price,
      'priceId': instance.priceId,
      'priceName': instance.priceName,
      'time': instance.time,
    };
