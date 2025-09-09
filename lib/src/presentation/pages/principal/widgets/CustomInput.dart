import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool requiredField;

  const CustomInput({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.requiredField = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (requiredField && (value == null || value.isEmpty)) {
          return 'Este campo es obligatorio';
        }
        return null;
      },
    );
  }
}
