import 'package:flutter/material.dart';
import 'package:seguridad_flutter/shared/components/title_section.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TitleSection(title:"SoftGenix"),
          Container(
            color: Colors.amber,
            width: 200,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("hola a todos"),
                Text("hola a todos"),
                Text("hola a todos"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
