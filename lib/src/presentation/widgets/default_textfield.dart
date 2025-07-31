import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  String label;
  String? errorText;
  IconData icon;
  Function(String text) onChanged;
  bool obscureText;

  DefaultTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.onChanged,
    this.errorText = '',
    this.obscureText = false
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      onChanged: (text) {
        onChanged(text);
      },
      decoration: InputDecoration(
        label: Text(label, style: TextStyle(color: Colors.white)),
        errorText: errorText,
        prefixIcon: Icon(icon, color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: TextStyle(color: Colors.white)
    );
  }
}
