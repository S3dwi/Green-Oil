import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_oil/sign_in_screen/email_text_field.dart';
import 'package:green_oil/auth_button.dart';
import 'package:green_oil/send_email_screen.dart';
import 'package:green_oil/sign_in_screen/sign_in_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordState();
  }
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  // Global key to track and validate the form
  final _form = GlobalKey<FormState>();

  var _enteredEmail = '';
  bool _isLoading = false;

  void _resetPassword() async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _enteredEmail.trim(),
        );
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => SendEmailScreen(
                text: 'BACK TO SIGN IN',
                onPressed: () {
                  //Navigate to Sign In screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  );
                },
              ),
            ),
          );
        }
      } on FirebaseAuthException catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message ?? 'Authentication failed.'),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false; // Stop loading
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents resizing on keyboard open
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40), // Space at top

            // Logo image at top center
            Image.asset(
              "assets/icon/logo.png",
              width: 60,
            ),

            const SizedBox(height: 8),

            // Title text
            Text(
              "Forgot Password",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),

            const SizedBox(height: 5),

            // Subtitle or welcoming text
            Text(
              "Be Recycled by join us today!",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),

            const SizedBox(height: 60),

            // Sign-In form with input fields
            Form(
              key: _form,
              child: Column(
                children: [
                  // Email input field
                  EmailTextField(
                    label: 'Email Address',
                    onSaved: (newValue) {
                      _enteredEmail = newValue!;
                    },
                  ),
                ],
              ),
            ),

            Spacer(),

            // Sign-in button
            AuthButton(
              onPressed: _isLoading ? () {} : _resetPassword,
              vertical: _isLoading ? 15 : 13,
              horizontal: _isLoading ? 165 : 96.25,
              child: _isLoading
                  ? SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  : Text(
                      'Resat Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
            ),

            const SizedBox(height: 20),

            // "Sign Up" option if the user doesn't have an account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Back to",
                  style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    // Navigate back to Sign-in screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
