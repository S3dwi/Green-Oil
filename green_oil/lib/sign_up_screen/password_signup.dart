import 'package:flutter/material.dart';

class PasswordSignup extends StatelessWidget {
  const PasswordSignup({
    super.key,
    required this.onSaved,
  });

  final void Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        obscureText: true,
        style: TextStyle(
          fontSize: 22,
          color: Theme.of(context).colorScheme.secondary,
        ),
        decoration: InputDecoration(
          labelText: 'Password (Required)',
          floatingLabelStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            // Color when label is floating (in focus)
          ),
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).disabledColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).disabledColor,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.onPrimary,
          filled: true,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          // Check for password length
          if (value.length < 8) {
            return 'Password must be at least 8 characters long';
          }
          // Check for at least one number in the password
          if (!RegExp(r'\d').hasMatch(value)) {
            return 'Password must contain at least one number';
          }
          // Check for at least one letter in the password
          if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
            return 'Password must contain at least one letter';
          }
          // Optionally check for at least one special character
          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
            return 'Password must contain at least one special character';
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }
}
