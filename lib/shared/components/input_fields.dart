import 'package:flutter/material.dart';

class InputFields extends StatelessWidget {
  final String textInput;
  final String hTPlaceHolder;
  final bool isPassword;
  final IconData? iconInput;

  const InputFields({
    super.key,
    required this.textInput,
    required this.hTPlaceHolder,
    this.isPassword = false,
    this.iconInput,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(
            textInput,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8), 
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              prefixIcon: iconInput != null ? Icon(iconInput, color: Colors.blueAccent) : null,
              hintText: hTPlaceHolder,
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
              filled: true,
              fillColor: Colors.grey[50], 
              contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
              
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blueAccent, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}