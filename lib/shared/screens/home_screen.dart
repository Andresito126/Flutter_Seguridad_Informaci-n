import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguridad_flutter/shared/session/session_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
             Divider(),
             Text(
              'panel de pruebas del wipe remoto',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            ElevatedButton.icon(
              onPressed: () async {
                // accedemos al manager y ejecutamos la función
                await context
                    .read<SessionProvider>()
                    .sessionManager
                    .populateSensitiveData();
                // leemos para confirmar
                await context
                    .read<SessionProvider>()
                    .sessionManager
                    .checkSensitiveData();
              },
              label: const Text('1. Generar Datos Sensibles'),
            ),

            ElevatedButton.icon(
              onPressed: () async {
                await context
                    .read<SessionProvider>()
                    .sessionManager
                    .checkSensitiveData();
              },
              label: const Text('2. Imprimir Datos Actuales'),
            ),
          ],
        ),
      ),
    );
  }
}
