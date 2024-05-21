import 'dart:convert';
import 'dart:io';

import 'package:agro/routes/app_pages.dart';
import 'package:agro/server/api/api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:permission_handler/permission_handler.dart';

part 'push_notifications_event.dart';
part 'push_notifications_state.dart';

/// Receive message when app is in background
@pragma('vm:entry-point')
Future<void> backgroundNotificationHandler(RemoteMessage message) async {
  logDebug("Push in background: ${message.data.toString()}");
}

class PushNotificationsBloc
    extends Bloc<PushNotificationsEvent, PushNotificationsState> with UiLoggy {
  late final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  PushNotificationsBloc()
      : super(PushNotificationsInitial()) {
    if (!kIsWeb) {
      _firebaseMessaging = FirebaseMessaging.instance;
      try {
        _setupPushNotifications();
      } catch (e) {
        loggy.error(e.toString());
      }
    }
  }

  Future<void> _setupPushNotifications() async {
    _setupFCMToken();

    /// Triggers when App is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (!Platform.isIOS) {
        loggy.debug("notification $message");
        _display(message);
      }
    });

    /// App is in background but opened and user taps on the notification
    FirebaseMessaging.onMessageOpenedApp
        .listen((message) => _handleTapOnPushNotification(message));

    /// Get notification info when its delivered in background
    FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);

    await _initializeLocalNotifications();
  }

   _handleTapOnPushNotification(RemoteMessage? remoteMessage) async {
    loggy.debug(" handle tap ${remoteMessage?.data}");
    final clickAction = remoteMessage?.data['messagetype'];
    if (clickAction == "TENDER") {
      final orderId = int.tryParse(remoteMessage?.data['tender_id']);
      await Get.toNamed(Routes.orderInfo, arguments: [orderId]);
    } else {}
  }

  _display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      loggy.debug("NOTIFICATION ${message.data}");
      await _notificationsPlugin.show(id, message.notification?.title,
          message.notification?.body, _getNotificationDetails(),
          payload: jsonEncode(message.data));
    } catch (e) {
      loggy.debug("display notification: ${e.toString()}");
    }
  }

  NotificationDetails _getNotificationDetails() {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'muzos_android_notification_channel', 'Main channel',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    return NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
  }

  _initializeLocalNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: const AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification,
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
      ),
    );

    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) async {
      if (response.payload != null) {
        loggy.debug("DidReceiveNotificationResponse: ${response.payload}");
        try {
          final data = jsonDecode(response.payload!);
          final clickAction = data['messagetype'];
          if (clickAction == "TENDER") {
            final int? orderId = int.tryParse(data['tender_id']);
            await Get.toNamed(Routes.orderInfo, arguments: [orderId]);
          } else {}
        } catch (e) {
          loggy.debug("handle tap error $e");
        }
      }
    });

    AndroidNotificationChannel channel = const AndroidNotificationChannel(
        'uagro_android_notification_channel', 'Main channel',
        importance: Importance.max, playSound: true, enableVibration: true);

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    loggy.debug("Did Receive Local Notification");
  }

  Future _setupFCMToken() async {
    await registerFCMToken();
    _firebaseMessaging.onTokenRefresh.listen((token) {
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
      loggy.debug("FCM token refreshed: $token");
      registerFCMToken();
    }).onError((err) {
      loggy.debug(err.toString());
    });
  }

  /// Pass specific token or null to try getting it from Firebase
  Future registerFCMToken() async {
    if (kIsWeb) {
      return;
    }

    final token = await _firebaseMessaging.getToken();
    if (token == null) {
      throw Exception("Couldn't get FCM token");
    }

    ApiAnswer apiAnswer =
        await Api().traider.sendDeviceToken(deviceToken: token);

    loggy.debug("FCM token:  $token");
    loggy.debug("FCM token: ${apiAnswer.data}");
    askForPermissionIfNeeded();
  }

  Future askForPermissionIfNeeded() async {
    if (await needToRequestPermission()) {
      askForPermission();
    }
  }

  Future askForPermission() async {
    final status = await Permission.notification.status;

    switch (status) {
      case PermissionStatus.denied:
        await Permission.notification.request();
        break;
      case PermissionStatus.granted:
        return;
      case PermissionStatus.restricted:
        openAppSettings();
        break;
      case PermissionStatus.limited:
        openAppSettings();
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
      case PermissionStatus.provisional:
        openAppSettings();
        break;
    }
  }

  Future<bool> needToRequestPermission() async {
    final status = await Permission.notification.status;

    return !status.isGranted;
  }
}
