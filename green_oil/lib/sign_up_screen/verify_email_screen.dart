import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_oil/primary_button.dart';
import 'package:green_oil/sign_in_screen/sign_in_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _VerifyEmailScreenState();
  }
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
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
              'Please check your email for the verification link.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            PrimaryButton(
              onPressed: () {
                // Send verification email here
                FirebaseAuth.instance.currentUser?.sendEmailVerification();
                if (mounted) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Verification link has been sent to your email. Please check your inbox or junk email.'),
                    ),
                  );
                }
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              label: 'Resend Email',
              vertical: 10,
              horizontal: 90,
            ),
            SizedBox(height: 24),
            TextButton(
              onPressed: () {
                //Navigate to Sign In screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              },
              child: Text(
                "BACK TO SIGN IN",
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
