// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bimarestan_doctors/core/api/api_consumer.dart' as _i12;
import 'package:bimarestan_doctors/core/api/app_interceptors.dart' as _i14;
import 'package:bimarestan_doctors/core/api/dio_consumer.dart' as _i13;
import 'package:bimarestan_doctors/core/services/snack_bar_service.dart' as _i9;
import 'package:bimarestan_doctors/features/splash/presentation/providers/splash_provider.dart'
    as _i10;
import 'package:bimarestan_doctors/features/user/data/datasources/user_local_data_source.dart'
    as _i11;
import 'package:bimarestan_doctors/features/user/data/datasources/user_remote_data_source.dart'
    as _i15;
import 'package:bimarestan_doctors/features/user/data/repositories/user_repository.dart'
    as _i16;
import 'package:bimarestan_doctors/features/user/presentation/providers/login_provider.dart'
    as _i6;
import 'package:bimarestan_doctors/features/user/presentation/providers/sign_up_provider.dart'
    as _i8;
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i5;
import 'package:rx_shared_preferences/rx_shared_preferences.dart' as _i7;
import 'package:stacked_services/stacked_services.dart' as _i3;

import 'register_module.dart' as _i17;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.BottomSheetService>(registerModule.bottomSheetService);
  gh.singleton<_i3.DialogService>(registerModule.dialogService);
  gh.singleton<_i4.Dio>(registerModule.dio);
  gh.lazySingleton<_i5.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.factory<_i6.LoginProvider>(() => _i6.LoginProvider());
  gh.singleton<_i3.NavigationService>(registerModule.navigationService);
  gh.lazySingleton<_i7.RxSharedPreferences>(() => registerModule.rxPref);
  await gh.factoryAsync<_i7.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.factory<_i8.SignUpProvider>(() => _i8.SignUpProvider());
  gh.lazySingleton<_i9.SnackBarService>(() => _i9.SnackBarService());
  gh.factory<_i10.SplashProvider>(() => _i10.SplashProvider());
  gh.lazySingleton<_i11.UserLocalDataSource>(() => _i11.UserLocalDataSource(
      rxSharedPreferences: gh<_i7.RxSharedPreferences>()));
  gh.lazySingleton<_i12.ApiConsumer>(
      () => _i13.DioConsumer(client: gh<_i4.Dio>()));
  gh.lazySingleton<_i14.AppInterceptors>(() => _i14.AppInterceptors(
      userLocalDataSource: gh<_i11.UserLocalDataSource>()));
  gh.lazySingleton<_i15.UserRemoteDataSource>(
      () => _i15.UserRemoteDataSource(apiConsumer: gh<_i12.ApiConsumer>()));
  gh.lazySingleton<_i16.UserRepository>(() => _i16.UserRepository(
        userRemoteDataSource: gh<_i15.UserRemoteDataSource>(),
        userLocalDataSource: gh<_i11.UserLocalDataSource>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i17.RegisterModule {}
