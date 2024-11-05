import 'package:flutter/material.dart';

import 'package:green_oil/nav_bar.dart';
import 'package:green_oil/primary_button.dart';
import 'package:green_oil/sign_in_screen/email_text_field.dart';
import 'package:green_oil/sign_in_screen/password_text_field.dart';
import 'package:green_oil/sign_up_screen/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    // Global key to track and validate the form
    final _form = GlobalKey<FormState>();

    var _enteredEmail = '';
    var _enteredPassword = '';

    // Function to handle SignIn
    void _signIn() {
      final isValid = _form.currentState!.validate();

      // If form is invalid, show error message and return
      if (!isValid) {
        // show error message ...
        return;
      }

      // Save form state and update variables
      _form.currentState!.save();
    }

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
              "Sign in",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 3),

            // Subtitle or welcoming text
            Text(
              "Be Recycled by join us today!",
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 50),

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
                  const SizedBox(height: 15),

                  // Password input field
                  PasswordTextField(
                    label: 'Password',
                    onSaved: (newValue) {
                      _enteredPassword = newValue!;
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // "Forgot Password" option
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Add forgot password logic here
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),

            // Sign-in button
            PrimaryButton(
              onPressed: _signIn,
              backgroundColor: Theme.of(context).primaryColor,
              label: "Sign in",
              horizontal: 145,
              vertical: 13,
            ),

            const SizedBox(height: 20),

            // "Sign Up" option if the user doesn't have an account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t Have an account?",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    // Navigate to the Sign-Up screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
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
