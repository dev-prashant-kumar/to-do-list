import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Buttons({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF111111), 
        foregroundColor: Colors.white,            
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        
        elevation: 4,
        shadowColor: Colors.black54,
      ),

      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
