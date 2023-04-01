// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bimarestan_doctors/core/error/exceptions.dart';
import 'package:bimarestan_doctors/core/error/failures.dart';
import 'package:bimarestan_doctors/features/profile/data/models/profile.dart';
import 'package:bimarestan_doctors/features/user/data/models/user_credentials_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../datasources/profile_remote_data_source.dart';

@lazySingleton
class ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  ProfileRepository({
    required this.remoteDataSource,
  });
  Future<Either<Failure, Profile>> getProfile() async {
    try {
      final response = await remoteDataSource.getProfile();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(msg: e.msg.toString()));
    }
  }

  Future<Either<Failure, Unit>> updateProfile(Profile profile) async {
    try {
      final response = await remoteDataSource.updateProfile(profile);
      return Right(response);
    } on ServerException catch (e) {
     
      return Left(ServerFailure(msg: e.msg.toString()));
    }
  }
}
