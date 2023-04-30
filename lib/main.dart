import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:bimarestan_doctors/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app.dart';
import 'core/resources/theme_manager.dart';
import 'core/services/snack_bar_service.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await configureDependencies();
  _initEasyLoading();
  runApp(MyApp());
}

void _initEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.light
    ..radius = 14;
}
