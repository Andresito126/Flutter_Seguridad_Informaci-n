import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguridad_flutter/app.dart';
import 'package:seguridad_flutter/shared/implementations/ScreenshootProtectionService_Impl.dart';
import 'package:seguridad_flutter/shared/services/ScreenshootProtection_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ScreenshootprotectionService>(
          create: (_) => ScreenshootprotectionserviceImpl(),
        ),
      ],
      child: DevicePreview(enabled: kIsWeb, builder: (context) => const MyApp()),
    )
  );
}
