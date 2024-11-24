
import 'package:flutter/material.dart';

class CalcularLimpiar extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;

  const CalcularLimpiar({
    Key? key,
    required this.texto,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
      ),
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}