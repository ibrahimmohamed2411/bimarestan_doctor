import 'dart:async';

import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/services/notification_service.dart';

part 'global_notifications_state.dart';

@injectable
class GlobalNotificationsProvider extends ChangeNotifier {
  final _notificationService = locator<NotificationService>();

  late StreamSubscription<RemoteMessage> notificationStream;
  void listenNotifications() async {
    notificationStream = FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          _notificationService.showNotification(notification: notification);
        }
      },
    );
  }

  @override
  void dispose() {
    notificationStream.cancel();
    super.dispose();
  }
}
