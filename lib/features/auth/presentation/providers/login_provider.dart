import 'package:flutter/cupertino.dart';
import 'package:seguridad_flutter/features/auth/domain/usecases/login_usecase.dart';
import 'package:seguridad_flutter/features/auth/presentation/screens/login_ui_state.dart';
import 'package:seguridad_flutter/shared/results/results.dart';
import 'package:seguridad_flutter/shared/session/session_provider.dart';

class LoginProvider extends ChangeNotifier {
  LoginUiState _state = LoginUiState();
  final LoginUsecase _loginUseCase;
  final SessionProvider _sessionProvider;

  
  LoginProvider(this._loginUseCase, this._sessionProvider);

  LoginUiState get state => _state;

  void resetState() {
    _state = LoginUiState(); 
    notifyListeners();
  }

  Future<void> login({required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      _state = _state.copyWith(
        status: LoginStatus.error,
        errorMessage: 'Por favor, llena todos los campos.',
      );
      notifyListeners();
      return;
    }

    _state = _state.copyWith(status: LoginStatus.loading);
    notifyListeners();
    
    final result = await _loginUseCase(email, password);

    switch (result) {
      case Success():
        await _sessionProvider.saveToken(result.data.token);
        _state = _state.copyWith(status: LoginStatus.success);
        notifyListeners();
        break;

      case Failure():
        _state = _state.copyWith(
          status: LoginStatus.error,
          errorMessage: result.toString().replaceAll('Exception: ', ''),
        );
        notifyListeners();
        break;
    }
  }
}