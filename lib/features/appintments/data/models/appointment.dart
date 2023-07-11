import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  final DateTime appointmentDate;
  final bool cancelled;
  final int clinicId;
  final bool finish;
  final int id;
  final int numPatient;
  final String patientFullName;
  final int patientId;
  final String patientPhone;
  final int price;
  final int priceId;
  final String priceName;
  final num time;

  Appointment({
    required this.appointmentDate,
    required this.cancelled,
    required this.clinicId,
    required this.finish,
    required this.id,
    required this.numPatient,
    required this.patientFullName,
    required this.patientId,
    required this.patientPhone,
    required this.price,
    required this.priceId,
    required this.priceName,
    required this.time,
  });
  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
