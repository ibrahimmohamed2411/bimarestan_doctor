// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bimarestan_doctors/core/api/api_consumer.dart' as _i17;
import 'package:bimarestan_doctors/core/api/app_interceptors.dart' as _i19;
import 'package:bimarestan_doctors/core/api/dio_consumer.dart' as _i18;
import 'package:bimarestan_doctors/core/services/notification_service.dart'
    as _i10;
import 'package:bimarestan_doctors/core/services/snack_bar_service.dart'
    as _i14;
import 'package:bimarestan_doctors/features/clinics/data/datasources/clinics_remote_data_source.dart'
    as _i20;
import 'package:bimarestan_doctors/features/clinics/data/repositories/clinics_repository.dart'
    as _i21;
import 'package:bimarestan_doctors/features/clinics/presentation/providers/clinics_provider.dart'
    as _i5;
import 'package:bimarestan_doctors/features/global_notifications/presentation/cubit/global_notifications_cubit.dart'
    as _i7;
import 'package:bimarestan_doctors/features/profile/data/datasources/profile_remote_data_source.dart'
    as _i22;
import 'package:bimarestan_doctors/features/profile/data/repositories/profile_repository.dart'
    as _i23;
import 'package:bimarestan_doctors/features/profile/presentation/providers/profile_provider.dart'
    as _i11;
import 'package:bimarestan_doctors/features/splash/presentation/providers/splash_provider.dart'
    as _i15;
import 'package:bimarestan_doctors/features/user/data/datasources/user_local_data_source.dart'
    as _i16;
import 'package:bimarestan_doctors/features/user/data/datasources/user_remote_data_source.dart'
    as _i24;
import 'package:bimarestan_doctors/features/user/data/repositories/user_repository.dart'
    as _i25;
import 'package:bimarestan_doctors/features/user/presentation/providers/categories_provider.dart'
    as _i4;
import 'package:bimarestan_doctors/features/user/presentation/providers/login_provider.dart'
    as _i9;
import 'package:bimarestan_doctors/features/user/presentation/providers/sign_up_provider.dart'
    as _i13;
import 'package:dio/dio.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i8;
import 'package:rx_shared_preferences/rx_shared_preferences.dart' as _i12;
import 'package:stacked_services/stacked_services.dart' as _i3;

import 'register_module.dart' as _i26;

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
  gh.factory<_i7.GlobalNotificationsProvider>(
      () => _i7.GlobalNotificationsProvider());
  gh.lazySingleton<_i8.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.factory<_i9.LoginProvider>(() => _i9.LoginProvider());
  gh.singleton<_i3.NavigationService>(registerModule.navigationService);
  gh.lazySingleton<_i10.NotificationService>(() => _i10.NotificationService());
  gh.factory<_i11.ProfileProvider>(() => _i11.ProfileProvider());
  gh.lazySingleton<_i12.RxSharedPreferences>(() => registerModule.rxPref);
  await gh.factoryAsync<_i12.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.factory<_i13.SignUpProvider>(() => _i13.SignUpProvider());
  gh.lazySingleton<_i14.SnackBarService>(() => _i14.SnackBarService());
  gh.factory<_i15.SplashProvider>(() => _i15.SplashProvider());
  gh.lazySingleton<_i16.UserLocalDataSource>(() => _i16.UserLocalDataSource(
      rxSharedPreferences: gh<_i12.RxSharedPreferences>()));
  gh.lazySingleton<_i17.ApiConsumer>(
      () => _i18.DioConsumer(client: gh<_i6.Dio>()));
  gh.lazySingleton<_i19.AppInterceptors>(() => _i19.AppInterceptors(
      userLocalDataSource: gh<_i16.UserLocalDataSource>()));
  gh.lazySingleton<_i20.ClinicRemoteDataSource>(
      () => _i20.ClinicRemoteDataSource(apiConsumer: gh<_i17.ApiConsumer>()));
  gh.lazySingleton<_i21.ClinicsRepository>(() => _i21.ClinicsRepository(
        remoteDataSource: gh<_i20.ClinicRemoteDataSource>(),
        userLocalDataSource: gh<_i16.UserLocalDataSource>(),
      ));
  gh.lazySingleton<_i22.ProfileRemoteDataSource>(
      () => _i22.ProfileRemoteDataSource(apiConsumer: gh<_i17.ApiConsumer>()));
  gh.lazySingleton<_i23.ProfileRepository>(() => _i23.ProfileRepository(
      remoteDataSource: gh<_i22.ProfileRemoteDataSource>()));
  gh.lazySingleton<_i24.UserRemoteDataSource>(
      () => _i24.UserRemoteDataSource(apiConsumer: gh<_i17.ApiConsumer>()));
  gh.lazySingleton<_i25.UserRepository>(() => _i25.UserRepository(
        userRemoteDataSource: gh<_i24.UserRemoteDataSource>(),
        userLocalDataSource: gh<_i16.UserLocalDataSource>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i26.RegisterModule {}
