import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecurityBlockedPage extends StatelessWidget {
  const SecurityBlockedPage({super.key});

  void _closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.security,
                    size: 72,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Acceso bloqueado',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'La aplicación detectó que la depuración USB está habilitada en el dispositivo.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Por motivos de seguridad, la aplicación no puede ejecutarse mientras esta configuración permanezca activa.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Desactive la opción "Depuración USB" desde las Opciones para desarrolladores y vuelva a abrir la aplicación.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  FilledButton(
                    onPressed: _closeApp,
                    child: const Text('Cerrar aplicación'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}