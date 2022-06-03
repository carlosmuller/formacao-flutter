import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:meetups/models/device.dart';
import 'package:meetups/screens/events_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'http/web.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      carPlay: false,
      badge: true,
      criticalAlert: true,
      provisional: false,
      sound: true);
  switch (settings.authorizationStatus) {
    case AuthorizationStatus.authorized:
    case AuthorizationStatus.provisional:
      print('Permissão recebida ${settings.authorizationStatus}');
      await _startPushNotificationsHandler(messaging);
      break;
    default:
      print('Permissão negada ${settings.authorizationStatus}');
      break;
  }
  runApp(App());
}

Future<void> _startPushNotificationsHandler(FirebaseMessaging messaging) async {
  String? token = await messaging.getToken();
  await setPushToken(token);
  //foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
    print('Recebi uma mensagem enquanto estava com app aberto');
    print('Mensagem: ${remoteMessage.data}');
    if (remoteMessage.notification != null) {
      print(
          'Mensagem tinha tambem:\n\ttitulo: "${remoteMessage.notification!.title}"\n\tbody: "${remoteMessage.notification!.body}"');
    }
  });
  //background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //terminated
  final notificationData = await FirebaseMessaging.instance.getInitialMessage();
  print(notificationData?.data);
  if (notificationData != null && notificationData.data['message'] != null && !notificationData.data['message'].isEmpty) {

    showMyDialog(notificationData.data['message']);
  }
}

void showMyDialog(String message) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (_) => AlertDialog(
      title: Text('Abri via notificação'),
      content: Text(message),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(navigatorKey.currentContext!),
          child: Text('Fechar'),
        ),
      ],
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Recebi uma mensagem enquanto estava com app no background');
  print('Mensagem: ${message}');
  if (message.notification != null) {
    print(
        'Mensagem tinha tambem:\n\ttitulo: "${message.notification!.title}"\n\tbody: "${message.notification!.body}"');
  }
}

Future<void> setPushToken(String? token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? prefsToken = prefs.getString('push-token');
  if (token != prefsToken && token != null) {
    await prefs.setString('push-token', token);
    if (!(prefs.getBool('token-sent') ?? false)) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final map = deviceInfo.toMap();
      final device =
          Device(brand: map['brand'], model: map['model'], token: token);
      sendDevice(device)
          .then((value) async => await prefs.setBool('token-sent', true))
          .catchError(
              (error) async => await prefs.setBool('token-sent', false));
      print("salvei novamente");
    }
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dev meetups',
      home: EventsScreen(),
    );
  }
}
