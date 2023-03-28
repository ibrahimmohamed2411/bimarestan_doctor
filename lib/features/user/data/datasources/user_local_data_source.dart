import 'dart:convert';

import 'package:bimarestan_doctors/features/user/data/models/login_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

const String USERCREDENTIALS = 'userCredentials';

@lazySingleton
class UserLocalDataSource {
  final RxSharedPreferences rxSharedPreferences;
  UserLocalDataSource({
    required this.rxSharedPreferences,
  });

  Future<void> saveUserCredentials(Map<String, dynamic> userCredentials) async {
    await rxSharedPreferences.setString(
      USERCREDENTIALS,
      json.encode(userCredentials),
    );
  }

  Stream<LoginResponseModel?> userCredentialsStream() {
    return rxSharedPreferences.getStringStream(USERCREDENTIALS).map(
      (userCredentials) {
        if (userCredentials == null) {
          return null;
        }
        return LoginResponseModel.fromJson(
          json.decode(userCredentials),
        );
      },
    );
  }

  Future<LoginResponseModel?> getUserCredentials() async {
    final userCredentials =
        await rxSharedPreferences.getString(USERCREDENTIALS);
    if (userCredentials == null) {
      return null;
    }
    return LoginResponseModel.fromJson(
      json.decode(userCredentials),
    );
  }

  Future<void> signOut() async {
    await rxSharedPreferences.remove(USERCREDENTIALS);
  }
}
