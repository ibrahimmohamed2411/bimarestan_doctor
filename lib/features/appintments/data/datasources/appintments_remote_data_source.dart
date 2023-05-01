// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bimarestan_doctors/core/api/end_points.dart';
import 'package:bimarestan_doctors/features/appintments/data/models/appointment.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_consumer.dart';

@lazySingleton
class AppointmentsRemoteDataSource {
  final ApiConsumer apiConsumer;
  AppointmentsRemoteDataSource({
    required this.apiConsumer,
  });
  Future<List<Appointment>> getAllAppointmentsByClinicIdAndDate(
      int ClinicId, DateTime date) async {
    final response = await apiConsumer.get(
        '${EndPoints.getAllAppointmentsByClinicIdAndDate}$ClinicId/${date.millisecondsSinceEpoch}');
    return response
        .map<Appointment>((json) => Appointment.fromJson(json))
        .toList();
  }
}
