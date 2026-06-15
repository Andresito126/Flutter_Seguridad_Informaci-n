import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:seguridad_flutter/app.dart';
import 'package:seguridad_flutter/features/auth/di/auth_module.dart';
import 'package:seguridad_flutter/features/auth/presentation/providers/login_provider.dart';
import 'package:seguridad_flutter/shared/di/app_container.dart';
import 'package:seguridad_flutter/shared/services/ScreenshootProtection_service.dart';
import 'package:seguridad_flutter/shared/session/session_provider.dart';

// FIREBASE
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  if (message.data['command'] == 'WIPE_DATA') {
    print('------------------------------------------\n');
    print('Wipe Remoto ejecutado en segundo plano...');
    const secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: 'tarjeta_credito');
    await secureStorage.delete(key: 'nip_cajero');
    await secureStorage.delete(key: 'saldo_bancario');
    await secureStorage.delete(key: 'historial_clinico');
    print("Datos sensibles destruidos.");
    print('------------------------------------------\n');
  }

  _showLocalNotification(message);
}

void _showLocalNotification(RemoteMessage message) {
  final notification = message.notification;

  const androidDetails = AndroidNotificationDetails(
    'default_channel',
    'Notificaciones',
    channelDescription: 'Canal principal de notificaciones',
    importance: Importance.high,
    priority: Priority.high,
  );

  flutterLocalNotificationsPlugin.show(
    notification.hashCode,
    notification?.title ?? 'Sin título',
    notification?.body ?? 'Sin contenido',
    NotificationDetails(android: androidDetails),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(android: androidSettings),
  );

  final fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  print("FCMToken $fcmToken");

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  print('Estado del permiso: ${settings.authorizationStatus}');

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    print('FCMToken actualizado: $newToken');
  });

  FirebaseMessaging.onMessage.listen(_showLocalNotification);

FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    // El wipe remoto cuando la app esta abierta
    if (message.data['command'] == 'WIPE_DATA') {
      const secureStorage = FlutterSecureStorage();
      await secureStorage.delete(key: 'tarjeta_credito');
      await secureStorage.delete(key: 'nip_cajero');
      await secureStorage.delete(key: 'saldo_bancario');
      await secureStorage.delete(key: 'historial_clinico');
      print('Datos sensibles destruidos.');
    }
    
    _showLocalNotification(message);
  });

  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    print('App abierta desde notificación: ${initialMessage.notification?.title}');
  }

  final appContainer = AppContainer();

  runApp(
    MultiProvider(
      providers: [
        Provider<ScreenshootprotectionService>.value(value: appContainer.screenshotService),
        ChangeNotifierProvider<SessionProvider>.value(value: appContainer.sessionProvider),
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => AuthModule(appContainer).loginProvider,
        ),
      ],
      child: DevicePreview(enabled: kIsWeb, builder: (context) => MyApp()),
    ),
  );
}