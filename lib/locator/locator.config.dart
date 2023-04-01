// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bimarestan_doctors/core/api/api_consumer.dart' as _i16;
import 'package:bimarestan_doctors/core/api/app_interceptors.dart' as _i18;
import 'package:bimarestan_doctors/core/api/dio_consumer.dart' as _i17;
import 'package:bimarestan_doctors/core/services/notification_service.dart'
    as _i9;
import 'package:bimarestan_doctors/core/services/snack_bar_service.dart'
    as _i13;
import 'package:bimarestan_doctors/features/clinics/data/datasources/clinics_remote_data_source.dart'
    as _i19;
import 'package:bimarestan_doctors/features/clinics/data/repositories/clinics_repository.dart'
    as _i20;
import 'package:bimarestan_doctors/features/clinics/presentation/providers/clinics_provider.dart'
    as _i5;
import 'package:bimarestan_doctors/features/profile/data/datasources/profile_remote_data_source.dart'
    as _i21;
import 'package:bimarestan_doctors/features/profile/data/repositories/profile_repository.dart'
    as _i22;
import 'package:bimarestan_doctors/features/profile/presentation/providers/profile_provider.dart'
    as _i10;
import 'package:bimarestan_doctors/features/splash/presentation/providers/splash_provider.dart'
    as _i14;
import 'package:bimarestan_doctors/features/user/data/datasources/user_local_data_source.dart'
    as _i15;
import 'package:bimarestan_doctors/features/user/data/datasources/user_remote_data_source.dart'
    as _i23;
import 'package:bimarestan_doctors/features/user/data/repositories/user_repository.dart'
    as _i24;
import 'package:bimarestan_doctors/features/user/presentation/providers/categories_provider.dart'
    as _i4;
import 'package:bimarestan_doctors/features/user/presentation/providers/login_provider.dart'
    as _i8;
import 'package:bimarestan_doctors/features/user/presentation/providers/sign_up_provider.dart'
    as _i12;
import 'package:dio/dio.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i7;
import 'package:rx_shared_preferences/rx_shared_preferences.dart' as _i11;
import 'package:stacked_services/stacked_services.dart' as _i3;

import 'register_module.dart' as _i25;

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
  gh.factory<_i4.CategoriesProvider>(() => _i4.CategoriesProvider());
  gh.factory<_i5.ClinicsProvider>(() => _i5.ClinicsProvider());
  gh.singleton<_i3.DialogService>(registerModule.dialogService);
  gh.singleton<_i6.Dio>(registerModule.dio);
  gh.lazySingleton<_i7.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.factory<_i8.LoginProvider>(() => _i8.LoginProvider());
  gh.singleton<_i3.NavigationService>(registerModule.navigationService);
  gh.lazySingleton<_i9.NotificationService>(() => _i9.NotificationService());
  gh.factory<_i10.ProfileProvider>(() => _i10.ProfileProvider());
  gh.lazySingleton<_i11.RxSharedPreferences>(() => registerModule.rxPref);
  await gh.factoryAsync<_i11.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.factory<_i12.SignUpProvider>(() => _i12.SignUpProvider());
  gh.lazySingleton<_i13.SnackBarService>(() => _i13.SnackBarService());
  gh.factory<_i14.SplashProvider>(() => _i14.SplashProvider());
  gh.lazySingleton<_i15.UserLocalDataSource>(() => _i15.UserLocalDataSource(
      rxSharedPreferences: gh<_i11.RxSharedPreferences>()));
  gh.lazySingleton<_i16.ApiConsumer>(
      () => _i17.DioConsumer(client: gh<_i6.Dio>()));
  gh.lazySingleton<_i18.AppInterceptors>(() => _i18.AppInterceptors(
      userLocalDataSource: gh<_i15.UserLocalDataSource>()));
  gh.lazySingleton<_i19.ClinicRemoteDataSource>(
      () => _i19.ClinicRemoteDataSource(apiConsumer: gh<_i16.ApiConsumer>()));
  gh.lazySingleton<_i20.ClinicsRepository>(() => _i20.ClinicsRepository(
        remoteDataSource: gh<_i19.ClinicRemoteDataSource>(),
        userLocalDataSource: gh<_i15.UserLocalDataSource>(),
      ));
  gh.lazySingleton<_i21.ProfileRemoteDataSource>(
      () => _i21.ProfileRemoteDataSource(apiConsumer: gh<_i16.ApiConsumer>()));
  gh.lazySingleton<_i22.ProfileRepository>(() => _i22.ProfileRepository(
      remoteDataSource: gh<_i21.ProfileRemoteDataSource>()));
  gh.lazySingleton<_i23.UserRemoteDataSource>(
      () => _i23.UserRemoteDataSource(apiConsumer: gh<_i16.ApiConsumer>()));
  gh.lazySingleton<_i24.UserRepository>(() => _i24.UserRepository(
        userRemoteDataSource: gh<_i23.UserRemoteDataSource>(),
        userLocalDataSource: gh<_i15.UserLocalDataSource>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i25.RegisterModule {}
