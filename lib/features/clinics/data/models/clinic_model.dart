import 'package:json_annotation/json_annotation.dart';

part 'clinic_model.g.dart';

@JsonSerializable()
class ClinicModel {
  final String address;
  final List<int> days;
  final String description;
  final int doctorId;
  final num endWork;
  final int id;
  final String name;
  final String phone;
  final num startWork;
  ClinicModel({
    required this.address,
    required this.days,
    required this.description,
    required this.doctorId,
    required this.endWork,
    required this.id,
    required this.name,
    required this.phone,
    required this.startWork,
  
  });
  factory ClinicModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicModelFromJson(json);
  Map<String, dynamic> toJson() => _$ClinicModelToJson(this);
}
