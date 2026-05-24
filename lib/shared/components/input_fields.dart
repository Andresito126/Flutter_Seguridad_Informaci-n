import 'package:flutter/material.dart';

class InputFields extends StatelessWidget {
  final String textInput;
  final String hTPlaceHolder;
  final bool isPassword;
  final IconData iconInput;

  final TextEditingController? controller;

  final bool obscureText;

  final VoidCallback? onTogglePassword;

  const InputFields({
    super.key,
    required this.textInput,
    required this.hTPlaceHolder,
    this.isPassword = false,
    required this.iconInput,
    this.controller,
    this.obscureText = false,
    this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),

      child: TextField(

        controller: controller,

        obscureText:
        isPassword ? obscureText : false,

        decoration: InputDecoration(

          labelText: textInput,

          hintText: hTPlaceHolder,

          prefixIcon: Icon(iconInput),

          suffixIcon: isPassword
              ? IconButton(

            onPressed: onTogglePassword,

            icon: Icon(
              obscureText
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
          )
              : null,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}