import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String labelText;
  final String? hintText;

  const EmailTextField({
    super.key,
    required this.controller,
    this.validator,
    this.labelText = 'Email',
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,

        prefixIcon: const Icon(Icons.email_outlined),
      ),
    );
  }
}
