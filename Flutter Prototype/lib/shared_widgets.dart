import 'package:flutter/material.dart';

/// Rounded input field used on auth screens
Widget roundedInputField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  bool obscureText = false,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
  );
}
