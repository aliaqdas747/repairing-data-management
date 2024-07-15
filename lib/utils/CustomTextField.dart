import 'package:flutter/material.dart';

class Custom_field extends StatelessWidget {
  final String label;
  final bool isVisible;
  final Icon Icon1;
  final TextEditingController controller;
  final TextInputType keyboardType;


  const Custom_field({super.key,
    required this.label, required this.Icon1, required this.isVisible, required this.controller, required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return  TextField(
      keyboardType: keyboardType,
      controller: controller,
         obscureText: isVisible,
      decoration: InputDecoration(
        prefixIcon: Icon1,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        label: Text(label),
      ),
    );
  }
}
