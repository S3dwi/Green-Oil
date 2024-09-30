import 'package:flutter/material.dart';

class ClickableCards extends StatelessWidget {
  const ClickableCards({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding:
              const EdgeInsets.symmetric(vertical: 10), // Reduced vertical size
          backgroundColor: Colors.white, // Same button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded edges
          ),
          shadowColor: Colors.black, // Shadow color
          elevation: 10, // Shadow elevation
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 28, // Same larger icon size
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13, // Slightly increased font size
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
