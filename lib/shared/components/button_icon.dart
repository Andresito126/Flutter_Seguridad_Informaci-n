import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 

class ButtonIcon extends StatelessWidget {
  final String imagePath;

  const ButtonIcon({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: 48, 
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
    
      child: SvgPicture.asset(
        imagePath,
        fit: BoxFit.fill,
      ),
    );
  }
}