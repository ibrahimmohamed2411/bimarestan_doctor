import 'package:bimarestan_doctors/core/error/exceptions.dart';
import 'package:bimarestan_doctors/core/error/failures.dart';
import 'package:bimarestan_doctors/features/clinics/data/models/clinic_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../user/data/datasources/user_local_data_source.dart';
import '../datasources/clinics_remote_data_source.dart';

@lazySingleton
class ClinicsRepository {
  final ClinicRemoteDataSource remoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  ClinicsRepository({
    required this.remoteDataSource,
    required this.userLocalDataSource,
  });
  Future<Either<Failure, List<ClinicModel>>> getAllClinicsByDoctorId() async {
    try {
      final credentials = await userLocalDataSource.getUserCredentials();
      final userId = credentials!.id;
      final response = await remoteDataSource.getAllClinicsByDoctorId(userId);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(msg: e.msg.toString()));
    }
  }
  Future<Either<Failure,Unit>> addClinic(ClinicModel clinic) async {
    try {
      final response = await remoteDataSource.addClinic(clinic);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(msg: e.msg.toString()));
    }
  }

  Future<Either<Failure,Unit>> removeClinic(ClinicModel clinic) async {
    try {
      final response = await remoteDataSource.removeClinic(clinic);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(msg: e.msg.toString()));
    }
  }
  Future<Either<Failure,Unit>> updateClinic(ClinicModel clinic) async {
    try {
      final response = await remoteDataSource.updateClinic(clinic);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(msg: e.msg.toString()));
    }
  }
}
