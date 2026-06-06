import 'dart:async';
import 'package:flutter/foundation.dart';

class InactivityViewModel extends ChangeNotifier {
  Timer? _timer;
  final int inactivitySeconds = 10; 
  final Function onSessionExpired;

  InactivityViewModel({required this.onSessionExpired}) {
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    
    _timer = Timer(Duration(seconds: inactivitySeconds), () {
      onSessionExpired();
    });
  }

  void resetTimer() {
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}