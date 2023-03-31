import 'package:bimarestan_doctors/core/error/failures.dart';
import 'package:bimarestan_doctors/features/user/data/models/category_model.dart';
import 'package:bimarestan_doctors/features/user/data/models/login_request_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';

@lazySingleton
class UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  UserRepository({
    required this.userRemoteDataSource,
    required this.userLocalDataSource,
  });
  Future<Either<Failure, Unit>> login({
    required LoginRequestModel loginRequestModel,
  }) async {
    try {
      final model = await userRemoteDataSource.login(
        loginRequestModel: loginRequestModel,
      );
      userLocalDataSource.saveUserCredentials(model);
      return Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(msg: e.msg.toString()));
    }
  }

  Future<Either<Failure, List<CategoryModel>>> getAllCategories() async{
    try {
      final model = await userRemoteDataSource.getAllCategories();
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(msg: e.msg.toString()));
    }
  }
}
