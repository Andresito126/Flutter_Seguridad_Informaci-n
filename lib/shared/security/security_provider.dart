import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:seguridad_flutter/shared/security/app_security_service.dart';

class SecurityProvider extends ChangeNotifier with WidgetsBindingObserver {
  final AppSecurityService _securityService;

  bool _isBlocked = false;
  Timer? _timer;

  bool get isBlocked => _isBlocked;

  SecurityProvider({required AppSecurityService securityService})
      : _securityService = securityService {
    WidgetsBinding.instance.addObserver(this);
    _startMonitoring();
  }

  void _startMonitoring() {
    _check();

    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _check());
  }

  Future<void> _check() async {
    final isSafe = await _securityService.isSafeToRun();
    final shouldBlock = !isSafe;

    if (shouldBlock != _isBlocked) {
      _isBlocked = shouldBlock;
      notifyListeners();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _check();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
