import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Asegúrate de asignar el controlador
      keyboardType: keyboardType,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 24.0),
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
    );
  }
}
