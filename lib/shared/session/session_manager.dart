import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  final FlutterSecureStorage secureStorage;

  SessionManager({
    required this.secureStorage,
  });

  static const String tokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    await secureStorage.write(key: tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return secureStorage.read(key: tokenKey);
  }

  Future<void> clearSession() async {
    secureStorage.delete(key: tokenKey);
  }
}