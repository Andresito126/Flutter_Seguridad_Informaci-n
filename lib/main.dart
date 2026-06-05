import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguridad_flutter/app.dart';
import 'package:seguridad_flutter/features/auth/di/auth_module.dart';
import 'package:seguridad_flutter/features/auth/presentation/providers/login_provider.dart';
import 'package:seguridad_flutter/shared/di/app_container.dart';
import 'package:seguridad_flutter/shared/services/ScreenshootProtection_service.dart';
import 'package:seguridad_flutter/shared/session/session_provider.dart';

void main() {
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
      child: DevicePreview(enabled: kIsWeb, builder: (context) => const MyApp()),
    ),
  );
}
