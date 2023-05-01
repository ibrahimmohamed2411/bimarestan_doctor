// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bimarestan_doctors/core/api/end_points.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:bimarestan_doctors/core/api/api_consumer.dart';
import 'package:bimarestan_doctors/features/clinics/data/models/clinic_model.dart';

@lazySingleton
class ClinicRemoteDataSource {
  final ApiConsumer apiConsumer;
  ClinicRemoteDataSource({
    required this.apiConsumer,
  });

  Future<List<ClinicModel>> getAllClinicsByDoctorId(int doctorId) async {
    final response = await apiConsumer.get(
      '${EndPoints.getClinicsByDoctorId}$doctorId',
    );
    return response.map<ClinicModel>((e) => ClinicModel.fromJson(e)).toList();
  }

  Future<Unit> addClinic(ClinicModel clinic) async {
    final response = await apiConsumer.post(
      EndPoints.addClinic,
      body: clinic.toJson(),
    );
    return unit;
  }

  Future<Unit> removeClinic(ClinicModel clinic) async {
    await apiConsumer.delete('${EndPoints.removeClinic}${clinic.id}');
    return unit;
  }
  Future<Unit> updateClinic(ClinicModel clinic) async {
    await apiConsumer.put(
      EndPoints.updateClinic,
      body: clinic.toJson(),
    );
    return unit;
  }
}
