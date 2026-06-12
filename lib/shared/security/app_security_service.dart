import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppSecurityService {
  final bool simulateProduction;
  final bool forceBlock;

  static const _platform = MethodChannel('com.Softgenix.seguridad_flutter/security');

  AppSecurityService({
    this.simulateProduction = false,
    this.forceBlock = false,
  });

  Future<bool> _isUsbDebuggingEnabled() async {
    try {
      final bool isEnabled = await _platform.invokeMethod('isUsbDebuggingEnabled');
      return isEnabled;
    } on PlatformException catch (_) {
      return false;
    }
  }

  Future<bool> isSafeToRun() async {
    if (forceBlock) {
      return false;
    }

    if (kDebugMode && !simulateProduction) {
      return true;
    }

    try {
      if (await _isUsbDebuggingEnabled()) {
        return false;
      }

      if (!kReleaseMode && !simulateProduction) {
        return true;
      }

      return true;
    } catch (_) {
      return false;
    }
  }
}