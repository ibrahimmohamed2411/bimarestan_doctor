// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bimarestan_doctors/core/api/api_consumer.dart';
import 'package:bimarestan_doctors/core/api/end_points.dart';
import 'package:bimarestan_doctors/features/user/data/models/user_credentials_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../models/profile.dart';

@lazySingleton
class ProfileRemoteDataSource {
  final ApiConsumer apiConsumer;
  ProfileRemoteDataSource({
    required this.apiConsumer,
  });

  Future<Profile> getProfile() async {
    final response = await apiConsumer.get(
      EndPoints.profile,
    );
    return Profile.fromJson(response);
  }

  Future<Unit> updateProfile(Profile profile) async {
    final response = await apiConsumer.put(
      EndPoints.updateProfile,
      body: profile.toJson(),
    );
    return unit;
  }
}
