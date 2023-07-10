import 'package:bimarestan_doctors/features/clinics/presentation/providers/clinics_provider.dart';
import 'package:bimarestan_doctors/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

import 'core/resources/theme_manager.dart';
import 'core/services/snack_bar_service.dart';
import 'features/global_notifications/presentation/cubit/global_notifications_cubit.dart';
import 'locator/locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalNotificationsProvider>(
          create: (context) =>
              locator<GlobalNotificationsProvider>()..listenNotifications(),
        ),
        ChangeNotifierProvider<ClinicsProvider>(
          create: (context) => locator(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          scaffoldMessengerKey: locator<SnackBarService>().key,
          navigatorKey: StackedService.navigatorKey,
          builder: EasyLoading.init(),
          theme: getApplicationTheme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
