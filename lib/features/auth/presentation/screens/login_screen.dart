import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguridad_flutter/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:seguridad_flutter/shared/components/ProtectedPage.dart';
import 'package:seguridad_flutter/shared/components/button_component.dart';
import 'package:seguridad_flutter/shared/components/button_icon.dart';
import 'package:seguridad_flutter/shared/components/input_fields.dart';
import 'package:seguridad_flutter/shared/components/title_section.dart';
import 'package:seguridad_flutter/shared/services/ScreenshootProtection_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProtectedPage(
        child: ChangeNotifierProvider(
          create: (_) => LoginViewmodel(),

          child: Scaffold(
            backgroundColor: Colors.white,

            body: SafeArea(
              child: Consumer<LoginViewmodel>(
                builder: (context, vm, child) {

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      TitleSection(title: "SoftGenix"),

                      InputFields(
                        textInput: "Email",
                        hTPlaceHolder: "Introduce tu gmail",
                        iconInput: Icons.email_outlined,
                        controller: vm.emailController,
                      ),

                      InputFields(
                        textInput: "Password",
                        hTPlaceHolder: "Introduce tu contraseña",
                        isPassword: true,
                        iconInput: Icons.lock_outline,
                        controller: vm.passwordController,
                        obscureText: vm.obscurePassword,
                        onTogglePassword: vm.togglePasswordVisibility,
                      ),

                      if (vm.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            vm.errorMessage!,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),

                      vm.isLoading
                          ? CircularProgressIndicator()
                          : ButtonComponent(
                        textButton: "Iniciar Sesión",

                        onPressed: () async {

                          final success =
                          await vm.login();

                          if (success) {

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Login exitoso",
                                ),
                              ),
                            );
                          }
                        },
                      ),

                      SizedBox(height: 24),

                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 24.0),

                        child: Row(
                          children: [

                            Expanded(
                              child: Divider(
                                color: Colors.grey[300],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),

                              child: Text(
                                "O continúa con",
                              ),
                            ),

                            Expanded(
                              child: Divider(
                                color: Colors.grey[300],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),

                      Padding(
                        padding: EdgeInsets.all(8.0),

                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,

                          children: [

                            ButtonIcon(
                              imagePath:
                              'assets/logos/google-icon.svg',
                            ),

                            SizedBox(width: 20),

                            ButtonIcon(
                              imagePath:
                              'assets/logos/apple-icon.svg',
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
    );

  }
}
