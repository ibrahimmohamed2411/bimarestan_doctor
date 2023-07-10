import 'package:json_annotation/json_annotation.dart';

part 'clinic_model.g.dart';

@JsonSerializable()
class ClinicModel {
  final String address;
  final List<int> days;
  final String description;
  final int doctorId;
  final num endWork;
  final int? id;
  final String name;
  final String phone;
  final num startWork;
  ClinicModel({
    required this.address,
    required this.days,
    required this.description,
    required this.doctorId,
    required this.endWork,
    this.id,
    required this.name,
    required this.phone,
    required this.startWork,
  })  : assert(startWork >= 0),
        assert(endWork < 24);
  factory ClinicModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicModelFromJson(json);
  Map<String, dynamic> toJson() => _$ClinicModelToJson(this);

  ClinicModel copyWith({
    String? address,
    List<int>? days,
    String? description,
    int? doctorId,
    num? endWork,
    int? id,
    String? name,
    String? phone,
    num? startWork,
  }) {
    return ClinicModel(
      address: address ?? this.address,
      days: days ?? this.days,
      description: description ?? this.description,
      doctorId: doctorId ?? this.doctorId,
      endWork: endWork ?? this.endWork,
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      startWork: startWork ?? this.startWork,
    );
  }
}
