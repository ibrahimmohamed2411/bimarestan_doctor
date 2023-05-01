// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bimarestan_doctors/core/api/api_consumer.dart' as _i18;
import 'package:bimarestan_doctors/core/api/app_interceptors.dart' as _i20;
import 'package:bimarestan_doctors/core/api/dio_consumer.dart' as _i19;
import 'package:bimarestan_doctors/core/services/notification_service.dart'
    as _i11;
import 'package:bimarestan_doctors/core/services/snack_bar_service.dart'
    as _i15;
import 'package:bimarestan_doctors/features/appintments/data/datasources/appintments_remote_data_source.dart'
    as _i21;
import 'package:bimarestan_doctors/features/appintments/data/repositories/appointments_repository.dart'
    as _i22;
import 'package:bimarestan_doctors/features/appintments/presentation/providers/appointments_provider.dart'
    as _i29;
import 'package:bimarestan_doctors/features/bottom_nav_bar/presentation/providers/bottom_nav_bar_provider.dart'
    as _i3;
import 'package:bimarestan_doctors/features/clinics/data/datasources/clinics_remote_data_source.dart'
    as _i23;
import 'package:bimarestan_doctors/features/clinics/data/repositories/clinics_repository.dart'
    as _i24;
import 'package:bimarestan_doctors/features/clinics/presentation/providers/clinics_provider.dart'
    as _i6;
import 'package:bimarestan_doctors/features/global_notifications/presentation/cubit/global_notifications_cubit.dart'
    as _i8;
import 'package:bimarestan_doctors/features/profile/data/datasources/profile_remote_data_source.dart'
    as _i25;
import 'package:bimarestan_doctors/features/profile/data/repositories/profile_repository.dart'
    as _i26;
import 'package:bimarestan_doctors/features/profile/presentation/providers/profile_provider.dart'
    as _i12;
import 'package:bimarestan_doctors/features/splash/presentation/providers/splash_provider.dart'
    as _i16;
import 'package:bimarestan_doctors/features/user/data/datasources/user_local_data_source.dart'
    as _i17;
import 'package:bimarestan_doctors/features/user/data/datasources/user_remote_data_source.dart'
    as _i27;
import 'package:bimarestan_doctors/features/user/data/repositories/user_repository.dart'
    as _i28;
import 'package:bimarestan_doctors/features/user/presentation/providers/categories_provider.dart'
    as _i5;
import 'package:bimarestan_doctors/features/user/presentation/providers/login_provider.dart'
    as _i10;
import 'package:bimarestan_doctors/features/user/presentation/providers/sign_up_provider.dart'
    as _i14;
import 'package:dio/dio.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i9;
import 'package:rx_shared_preferences/rx_shared_preferences.dart' as _i13;
import 'package:stacked_services/stacked_services.dart' as _i4;

import 'register_module.dart' as _i30;

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
  gh.factory<_i3.BottomNavBarProvider>(() => _i3.BottomNavBarProvider());
  gh.singleton<_i4.BottomSheetService>(registerModule.bottomSheetService);
  gh.factory<_i5.CategoriesProvider>(() => _i5.CategoriesProvider());
  gh.factory<_i6.ClinicsProvider>(() => _i6.ClinicsProvider());
  gh.singleton<_i4.DialogService>(registerModule.dialogService);
  gh.singleton<_i7.Dio>(registerModule.dio);
  gh.factory<_i8.GlobalNotificationsProvider>(
      () => _i8.GlobalNotificationsProvider());
  gh.lazySingleton<_i9.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.factory<_i10.LoginProvider>(() => _i10.LoginProvider());
  gh.singleton<_i4.NavigationService>(registerModule.navigationService);
  gh.lazySingleton<_i11.NotificationService>(() => _i11.NotificationService());
  gh.factory<_i12.ProfileProvider>(() => _i12.ProfileProvider());
  gh.lazySingleton<_i13.RxSharedPreferences>(() => registerModule.rxPref);
  await gh.factoryAsync<_i13.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.factory<_i14.SignUpProvider>(() => _i14.SignUpProvider());
  gh.lazySingleton<_i15.SnackBarService>(() => _i15.SnackBarService());
  gh.factory<_i16.SplashProvider>(() => _i16.SplashProvider());
  gh.lazySingleton<_i17.UserLocalDataSource>(() => _i17.UserLocalDataSource(
      rxSharedPreferences: gh<_i13.RxSharedPreferences>()));
  gh.lazySingleton<_i18.ApiConsumer>(
      () => _i19.DioConsumer(client: gh<_i7.Dio>()));
  gh.lazySingleton<_i20.AppInterceptors>(() => _i20.AppInterceptors(
      userLocalDataSource: gh<_i17.UserLocalDataSource>()));
  gh.lazySingleton<_i21.AppointmentsRemoteDataSource>(() =>
      _i21.AppointmentsRemoteDataSource(apiConsumer: gh<_i18.ApiConsumer>()));
  gh.lazySingleton<_i22.AppointmentsRepository>(() =>
      _i22.AppointmentsRepository(
          remoteDataSource: gh<_i21.AppointmentsRemoteDataSource>()));
  gh.lazySingleton<_i23.ClinicRemoteDataSource>(
      () => _i23.ClinicRemoteDataSource(apiConsumer: gh<_i18.ApiConsumer>()));
  gh.lazySingleton<_i24.ClinicsRepository>(() => _i24.ClinicsRepository(
        remoteDataSource: gh<_i23.ClinicRemoteDataSource>(),
        userLocalDataSource: gh<_i17.UserLocalDataSource>(),
      ));
  gh.lazySingleton<_i25.ProfileRemoteDataSource>(
      () => _i25.ProfileRemoteDataSource(apiConsumer: gh<_i18.ApiConsumer>()));
  gh.lazySingleton<_i26.ProfileRepository>(() => _i26.ProfileRepository(
      remoteDataSource: gh<_i25.ProfileRemoteDataSource>()));
  gh.lazySingleton<_i27.UserRemoteDataSource>(
      () => _i27.UserRemoteDataSource(apiConsumer: gh<_i18.ApiConsumer>()));
  gh.lazySingleton<_i28.UserRepository>(() => _i28.UserRepository(
        userRemoteDataSource: gh<_i27.UserRemoteDataSource>(),
        userLocalDataSource: gh<_i17.UserLocalDataSource>(),
      ));
  gh.factory<_i29.AppointmentsProvider>(() => _i29.AppointmentsProvider(
      appointmentsRepository: gh<_i22.AppointmentsRepository>()));
  return getIt;
}

class _$RegisterModule extends _i30.RegisterModule {}
