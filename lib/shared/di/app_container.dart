import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:seguridad_flutter/shared/implementations/ScreenshootProtectionService_Impl.dart';
import 'package:seguridad_flutter/shared/network/api_client.dart';
import 'package:seguridad_flutter/shared/services/ScreenshootProtection_service.dart';
import 'package:seguridad_flutter/shared/session/session_manager.dart';
import 'package:seguridad_flutter/shared/session/session_provider.dart';

class AppContainer {
  late final FlutterSecureStorage secureStorage;
  late final ApiClient apiClient;
  late final SessionManager sessionManager;
  late final SessionProvider sessionProvider;
  late final ScreenshootprotectionService screenshotService;

  AppContainer() {
    secureStorage = const FlutterSecureStorage();
    apiClient = ApiClient(baseUrl: 'http://localhost:3000');
    sessionManager = SessionManager(secureStorage: secureStorage);
    sessionProvider = SessionProvider(sessionManager: sessionManager);
    screenshotService = ScreenshootprotectionserviceImpl();
  }
}