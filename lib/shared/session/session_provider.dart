import 'package:flutter/cupertino.dart';
import 'package:seguridad_flutter/shared/session/session_manager.dart';

class SessionProvider extends ChangeNotifier {
  final SessionManager sessionManager;
  String? _token;
  String? get token => _token;
  bool get isAuthenticated => _token != null;

  SessionProvider({
    required this.sessionManager
  });

Future<void> loadSession() async {
    final isLocked = await sessionManager.isSessionLocked();
    
    if (isLocked) {
      _token = null; 
    } else {
      _token = await sessionManager.getToken();
    }
    
    notifyListeners();
  }

  Future<void> saveToken(String token) async{
    await sessionManager.saveToken(token);
    _token = token;
    notifyListeners();
  }

  Future<void> lockSession() async {
    final now = DateTime.now().toIso8601String();
    await sessionManager.saveInactivityTime(now); 
    _token = null; 
    notifyListeners();
  }


Future<void> logout() async {
    await sessionManager.clearSession();
    _token = null;
    notifyListeners();
  }
}