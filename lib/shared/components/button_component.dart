import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final String textButton;

  const ButtonComponent({
    super.key,
    required this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: 52, 
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, 
            foregroundColor: Colors.white,       
            elevation: 2,                        
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), 
            ),
          ),
          child: Text(
            textButton,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}