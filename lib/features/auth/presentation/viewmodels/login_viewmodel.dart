
import 'package:flutter/cupertino.dart';

class LoginViewmodel extends ChangeNotifier {
  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  bool obscurePassword = true;

  Future<bool> login() async {

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    final email = emailController.text;
    final password = passwordController.text;

    if (email == "admin@gmail.com" &&
        password == "12345678") {

      isLoading = false;
      notifyListeners();

      return true;
    }

    errorMessage = "Correo o contraseña incorrectos";

    isLoading = false;
    notifyListeners();

    return false;
  }

  void togglePasswordVisibility () {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}