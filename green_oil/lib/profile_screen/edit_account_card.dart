import 'package:flutter/material.dart';

class EditAccountCard extends StatelessWidget {
  const EditAccountCard({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 120,
      child: Card(
        elevation: 4,
        shadowColor: Theme.of(context).shadowColor,
        color: Theme.of(context).colorScheme.onPrimary,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  // labelText: label,
                  hintText: value,
                  floatingLabelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  // Regex pattern for validating an email address
                  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                  final regExp = RegExp(pattern);

                  if (!regExp.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
