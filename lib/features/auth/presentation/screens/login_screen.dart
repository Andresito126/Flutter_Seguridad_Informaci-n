import 'package:flutter/material.dart';
import 'package:seguridad_flutter/shared/components/button_component.dart';
import 'package:seguridad_flutter/shared/components/button_icon.dart';
import 'package:seguridad_flutter/shared/components/input_fields.dart';
import 'package:seguridad_flutter/shared/components/title_section.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleSection(title: "SoftGenix"),
            InputFields(
              textInput: "Email",
              hTPlaceHolder: "Introduce tu gmail",
              iconInput: Icons.email_outlined,
            ),
            InputFields(
              textInput: "Password",
              hTPlaceHolder: "Introduce tu contraseña",
              isPassword: true,
              iconInput: Icons.lock_outline,
            ),

            ButtonComponent(textButton: "Iniciar Sesión"),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "O continúa con",
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonIcon(imagePath: 'assets/logos/google-icon.svg'),
                  SizedBox(width: 20),
                  ButtonIcon(imagePath: 'assets/logos/apple-icon.svg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
