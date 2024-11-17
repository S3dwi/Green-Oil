import 'package:flutter/material.dart';

class SendEmailScreen extends StatelessWidget {
  const SendEmailScreen({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/email.png",
              height: 200,
            ),
            const SizedBox(height: 40),
            Text(
              'Please check your email for resat password link.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).colorScheme.primary,
                  shadows: [
                    Shadow(
                      color: Theme.of(context).colorScheme.primary,
                      // Match background color to create "gap"
                      offset: Offset(0, -5),
                      // Adjust vertical offset to control space
                    ),
                  ],
                  decorationThickness: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
