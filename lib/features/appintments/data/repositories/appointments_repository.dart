import 'package:bimarestan_doctors/core/error/exceptions.dart';
import 'package:bimarestan_doctors/core/error/failures.dart';
import 'package:bimarestan_doctors/features/appintments/data/datasources/appintments_remote_data_source.dart';
import 'package:bimarestan_doctors/features/appintments/data/models/appointment.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppointmentsRepository {
  final AppointmentsRemoteDataSource remoteDataSource;
  AppointmentsRepository({
    required this.remoteDataSource,
  });
  Future<Either<Failure, List<Appointment>>>
      getAllAppointmentsByClinicIdAndDate(int ClinicId, DateTime date) async {
    try {
      final appointments = await remoteDataSource
          .getAllAppointmentsByClinicIdAndDate(ClinicId, date);
      return Right(appointments);
    } on ServerException catch (e) {
      return Left(ServerFailure(msg: e.msg.toString()));
    }
  }
}
