import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_oil/primary_button.dart';
import 'package:green_oil/sign_in_screen/sign_in_screen.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

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
            const Text(
              'Please check your email for the verification link.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            PrimaryButton(
              onPressed: () {
                // Send verification email here
                FirebaseAuth.instance.currentUser?.sendEmailVerification();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              },
              backgroundColor: Theme.of(context).primaryColor,
              label: 'Resend Email',
              vertical: 10,
              horizontal: 90,
            ),
            SizedBox(height: 40),
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
                  color: Color.fromARGB(0, 110, 48, 48),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).primaryColor,
                  shadows: [
                    Shadow(
                      color: Theme.of(context)
                          .primaryColor, // Match background color to create "gap"
                      offset: Offset(
                          0, -5), // Adjust vertical offset to control space
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
