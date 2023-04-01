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
}
