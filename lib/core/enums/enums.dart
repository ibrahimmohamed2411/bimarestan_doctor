import 'package:freezed_annotation/freezed_annotation.dart';

enum RoleId {
  @JsonValue(1)
  doctor,
  @JsonValue(2)
  patient,
  @JsonValue(3)
  nurse;

  static RoleId fromString(String role) {
    switch (role) {
      case 'patient':
        return RoleId.patient;
      case 'doctor':
        return RoleId.doctor;
      case 'nurse':
        return RoleId.nurse;
      default:
        throw Exception('Invalid role');
    }
  }

  int get roleId {
    switch (this) {
      case RoleId.patient:
        return 1;
      case RoleId.doctor:
        return 2;
      case RoleId.nurse:
        return 3;
    }
  }
}
