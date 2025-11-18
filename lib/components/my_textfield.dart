import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String tFHintText;
  final Icon tFIcon;
  final TextEditingController tFController;
  final bool isObscure;
  final String? Function(String?)? tFValidator;

  const MyTextField({
    super.key,
    required this.tFHintText,
    required this.tFIcon,
    required this.tFController,
    required this.isObscure,
    this.tFValidator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: tFValidator,
      controller: tFController,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: tFHintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: tFIcon,
      ),
    );
  }
}