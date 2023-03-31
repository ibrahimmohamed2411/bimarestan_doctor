import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "high_important_channel",
  "High Importance Notifications",
  description: 'this channel is used for important notification',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessaggingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // if (message.data['notificationType'] == 'call') {
  //   String fromName = message.data['senderUserName'] as String;
  //   String channel = message.data['channelName'] as String;
  //   String agoraToken = message.data['agoraToken'] as String;
  //   String senderImage = message.data['senderImage'] as String;
  //   return await NotificationService().showCallNotification(
  //     fromName,
  //     channel,
  //     agoraToken,
  //     senderImage,
  //   );
  // }
}

@lazySingleton
class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessaggingBackgroundHandler);
    setupFlutterNotification();
    setupNotificationAction();
  }
  Future<String?> getFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  void setupFlutterNotification() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void setupNotificationAction() async {
    FlutterCallkitIncoming.onEvent.listen((event) async {
      switch (event!.event) {
        case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_INCOMING:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_START:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_ACCEPT:
          break;
        case Event.ACTION_CALL_DECLINE:
          await FlutterCallkitIncoming.endAllCalls();
          break;
        case Event.ACTION_CALL_ENDED:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_TIMEOUT:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_CALLBACK:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_TOGGLE_HOLD:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_TOGGLE_MUTE:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_TOGGLE_DMTF:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_TOGGLE_GROUP:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
          // TODO: Handle this case.
          break;
      }
    });
  }

  Future<String?> getNotificationToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      return token;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future showCallNotification(String fromName, String channel,
      String agoraToken, String senderImage) async {
    CallKitParams callKitParams = CallKitParams(
      id: Uuid().v4(),
      nameCaller: fromName,
      appName: 'iFetcher',
      avatar: senderImage,
      // handle: '0123456789',
      type: 0,
      textAccept: 'Accept',
      textDecline: 'Decline',
      textMissedCall: 'Missed call',
      textCallback: 'Call back',
      duration: 30000,
      extra: <String, dynamic>{
        'channel': channel,
        'agoraToken': agoraToken,
      },
      // headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        isShowCallback: false,
        isShowMissedCallNotification: true,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        // backgroundUrl: 'https://i.pravatar.cc/500',
        actionColor: '#4CAF50',
        incomingCallNotificationChannelName: "Incoming Call",
        missedCallNotificationChannelName: "Missed Call",
      ),
      ios: IOSParams(
        iconName: 'CallKitLogo',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
  }

  void showNotification({required RemoteNotification notification}) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          color: Colors.blueAccent,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}
