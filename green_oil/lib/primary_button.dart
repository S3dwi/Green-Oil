import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.label,
  });

  final void Function() onPressed;
  final Color backgroundColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 145,
        ),
        //shadow looks only apply horizontally, need to improve
        elevation: 6, // This adds the shadow
        shadowColor: Theme.of(context).shadowColor, // Shadow color
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
