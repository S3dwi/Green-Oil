import 'package:flutter/material.dart';

class SignTextfield extends StatelessWidget {
  const SignTextfield({
    super.key,
    required this.label,
    required this.controller,
    required this.obscureText,
  });

  final String label;
  final controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(fontSize: 22),
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).disabledColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).disabledColor,
            ),
          ),
          fillColor: Theme.of(context).cardColor,
          filled: true,
        ),
      ),
    );
  }
}
