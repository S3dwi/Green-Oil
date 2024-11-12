import 'package:flutter/material.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    super.key,
    required this.onSaved,
  });

  final void Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        style: TextStyle(
          fontSize: 22,
          color: Theme.of(context).colorScheme.secondary,
        ),
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Phone Number (Required)',
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
            return 'Please enter your mobile number';
          }
          // Ensure all characters are digits
          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
            return 'Mobile number must contain only digits';
          }
          // Check for standard mobile number length
          if (value.length != 10) {
            return 'Mobile number must be 10 digits long';
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }
}
