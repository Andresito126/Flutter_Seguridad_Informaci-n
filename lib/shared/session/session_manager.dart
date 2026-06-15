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


  // FCM
  // Llaves de los datos sensibles
  static const String secret1Key = 'tarjeta_credito';
  static const String secret2Key = 'nip_cajero';
  static const String secret3Key = 'saldo_bancario';
  static const String secret4Key = 'historial_clinico';


  Future<void> populateSensitiveData() async {
    await secureStorage.write(key: secret1Key, value: '4152-3333-2222-1111');
    await secureStorage.write(key: secret2Key, value: '8541');
    await secureStorage.write(key: secret3Key, value: '\$150,000.00');
    await secureStorage.write(key: secret4Key, value: 'Alergia a la penicilina');
    print('\n Datos sensibles INYECTADOS correctamente.');
  }

  // metodo para leer e imprimir cómo está el almacenamiento
  Future<void> checkSensitiveData() async {
    print('\n--- REVISANDO ALMACENAMIENTO ---');
    final t1 = await secureStorage.read(key: secret1Key);
    final t2 = await secureStorage.read(key: secret2Key);
    final t3 = await secureStorage.read(key: secret3Key);
    final t4 = await secureStorage.read(key: secret4Key);

    // Si todos son nulos, significa que se borraron
    if (t1 == null && t2 == null && t3 == null && t4 == null) {
      print('RESULTADO: El almacenamiento está vacio.');
      print(' Los datos fueron destruidos exitosamente');
    } else {
      print('Tarjeta: $t1');
      print('NIP: $t2');
      print('Saldo: $t3');
      print('Historial: $t4');
    }
    print('------------------------------------------\n');
  }

}