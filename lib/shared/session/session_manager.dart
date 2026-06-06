import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  final FlutterSecureStorage secureStorage;
  static const String timeKey = 'inactivity_time';

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

  Future<void> saveInactivityTime(String timestamp) async {
    await secureStorage.write(key: timeKey, value: timestamp);
  }

  Future<bool> isSessionLocked() async {
    final lockedTime = await secureStorage.read(key: timeKey);
    return lockedTime != null; 
  }



Future<void> clearSession() async {
    await secureStorage.delete(key: tokenKey);
    await secureStorage.delete(key: timeKey);
  }
}