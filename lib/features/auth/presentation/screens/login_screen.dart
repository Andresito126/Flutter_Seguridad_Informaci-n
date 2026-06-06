import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:detect_fake_location/detect_fake_location.dart';
import 'package:seguridad_flutter/features/auth/presentation/providers/login_provider.dart';
import 'package:seguridad_flutter/features/auth/presentation/screens/login_ui_state.dart';
import 'package:seguridad_flutter/features/auth/presentation/viewmodels/inactivity_view_model.dart';
import 'package:seguridad_flutter/shared/components/ProtectedPage.dart';
import 'package:seguridad_flutter/shared/components/button_component.dart';
import 'package:seguridad_flutter/shared/components/button_icon.dart';
import 'package:seguridad_flutter/shared/components/input_fields.dart';
import 'package:seguridad_flutter/shared/components/title_section.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // VARIABLES DE ESTADO PARA EL CONTROL DEL GPS
  bool _usandoFakeGPS = false;
  bool _verificandoGPS = true;

  // CONTROLLERS
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // SE EJECUTA LA COMPROBACIÓN APENAS ABRE LA PANTALLA
    _verificarFakeGPS();
  }

  Future<void> _verificarFakeGPS() async {
    setState(() {
      _verificandoGPS = true;
    });

    try {
      bool isFake = await DetectFakeLocation().detectFakeLocation();

      setState(() {
        _usandoFakeGPS = isFake;
        _verificandoGPS = false;
      });
    } catch (e) {
      print("Error al detectar Fake GPS: $e");
      setState(() {
        _verificandoGPS =
            false; // En caso de error, no bloqueamos al usuario drásticamente
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final signInProvider = context.watch<LoginProvider>();
    final state = signInProvider.state;
    

    // Navagación
if (state.status == LoginStatus.success) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        
        context.read<LoginProvider>().resetState();

        context.read<InactivityViewModel>().resetTimer();

        Navigator.of(context).pushReplacementNamed('/home');
        
      });
    }

    // CASO A: MIENTRAS COMPRUEBA EL GPS, SE MUESTRA CARGANDO
    if (_verificandoGPS) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // CASO B: SI DETECTA UN FAKE GPS, SE CURVA EL FLUJO Y SE BLOQUEA LA PANTALLA
    if (_usandoFakeGPS) {
      return Scaffold(
        backgroundColor: Colors.red[50],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.security_rounded, size: 80, color: Colors.red),
                const SizedBox(height: 20),
                const Text(
                  '¡Entorno inseguro detectado!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Por motivos de protección, esta aplicación no permite el acceso mediante el uso de Fake GPS o ubicaciones simuladas. Desactívalo para continuar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 30),
                ButtonComponent(
                  textButton: "Volver a verificar",
                  onPressed: _verificarFakeGPS,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // CASO C: SI EL ENTORNÓ ES SEGURO, RENDERIZA TU LOGIN ORIGINAL
    return ProtectedPage(
      child: Scaffold(
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
                controller: _emailController,
              ),

              InputFields(
                textInput: "Password",
                hTPlaceHolder: "Introduce tu contraseña",
                isPassword: true,
                iconInput: Icons.lock_outline,
                controller: _passwordController,
                obscureText: true,
                onTogglePassword: () {},
              ),

              if (state.status == LoginStatus.error)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    state.errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),

              state.status == LoginStatus.loading
                  ? CircularProgressIndicator()
                  : ButtonComponent(
                      textButton: "Iniciar Sesión",
                      onPressed: () {
                        context.read<LoginProvider>().login(
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
                        );
                      },
                    ),

              SizedBox(height: 24),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),

                child: Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300])),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),

                      child: Text("O continúa con"),
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
      ),
    );
  }
}
