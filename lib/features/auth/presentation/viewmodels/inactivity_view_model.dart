import 'dart:async';
import 'package:flutter/foundation.dart';

class InactivityViewModel extends ChangeNotifier {
  Timer? _timer;
  final int inactivityMinutes = 1; 
  final Function onSessionExpired;

  InactivityViewModel({required this.onSessionExpired}) {
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    
    _timer = Timer(Duration(minutes: inactivityMinutes), () {
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