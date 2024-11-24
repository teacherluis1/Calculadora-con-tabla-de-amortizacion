import 'package:flutter/material.dart';

class Botones extends StatelessWidget {
  final String etiqueta;
  final String hintText;
  final TextInputType tipoTeclado;
  final TextEditingController? controlador;
  final String? Function(String?)? validador;

  const Botones({
    Key? key,
    required this.etiqueta,
    required this.hintText,
    this.tipoTeclado = TextInputType.text,
    this.controlador,
    this.validador,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          etiqueta,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          controller: controlador,
          keyboardType: tipoTeclado,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            contentPadding: EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 15.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.green, width: 2.0),
            ),
          ),
          validator: validador,
        ),
      ],
    );
  }
}