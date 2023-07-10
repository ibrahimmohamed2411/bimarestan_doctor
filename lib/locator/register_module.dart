import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

@module
abstract class RegisterModule {
  // @injectable
  // GoogleSignIn get googleSignIn => GoogleSignIn();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  RxSharedPreferences get rxPref =>
      RxSharedPreferences(SharedPreferences.getInstance());
  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker();

  @singleton
  NavigationService get navigationService => NavigationService();
  @singleton
  Dio get dio => Dio();
  @singleton
  DialogService get dialogService => DialogService();

  @singleton
  BottomSheetService get bottomSheetService => BottomSheetService();
}
