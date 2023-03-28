import 'package:bimarestan_doctors/core/api/api_consumer.dart';
import 'package:bimarestan_doctors/core/api/end_points.dart';
import 'package:bimarestan_doctors/features/user/data/datasources/user_local_data_source.dart';
import 'package:bimarestan_doctors/features/user/data/models/login_response_model.dart';
import 'package:injectable/injectable.dart';

import '../models/login_request_model.dart';

@lazySingleton
class UserRemoteDataSource {
  final ApiConsumer apiConsumer;
  UserRemoteDataSource({
    required this.apiConsumer,
  });
  Future<LoginResponseModel> login({
    required LoginRequestModel loginRequestModel,
  }) async {
    final response = await apiConsumer.post(
      EndPoints.login,
      body: loginRequestModel.toJson(),
    );
    return  LoginResponseModel.fromJson(response);
  }
}
