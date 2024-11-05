import 'package:flutter/material.dart';

import 'package:green_oil/primary_button.dart';
import 'package:green_oil/sign_in_screen/email_text_field.dart';
import 'package:green_oil/sign_up_screen/name_text_field.dart';
import 'package:green_oil/sign_in_screen/password_text_field.dart';
import 'package:green_oil/sign_up_screen/phone_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Global key to track and validate the form
  final _form = GlobalKey<FormState>();

  var _enteredName = '';

  // Function to handle account creation
  void _createAccount() {
    final isValid = _form.currentState!.validate();

    // If form is invalid, show error message and return
    if (!isValid) {
      // show error message ...
      return;
    }

    // Save form state and update variables
    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Avoid bottom inset adjustments
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40), // Spacing at top

            // Logo image at top center
            Image.asset(
              "assets/icon/logo.png",
              width: 60,
            ),

            const SizedBox(height: 8),

            // Screen title
            Text(
              "Create Account",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 3),

            // Subtitle
            Text(
              "Be Recycled by join us today!",
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 50), // Space before form

            // Sign-Up form with input fields
            Form(
              key: _form,
              child: Column(
                children: [
                  // Name input field
                  NameTextField(
                    onSaved: (newValue) {
                      _enteredName = newValue!;
                    },
                  ),
                  const SizedBox(height: 15),

                  // Phone number input field
                  PhoneTextField(
                    onSaved: (newValue) {
                      _enteredName = newValue!;
                    },
                  ),
                  const SizedBox(height: 15),

                  // Email input field with label
                  EmailTextField(
                    label: 'Email Address (Required)',
                    onSaved: (newValue) {
                      _enteredName = newValue!;
                    },
                  ),
                  const SizedBox(height: 15),

                  // Password input field with label
                  PasswordTextField(
                    label: 'Password (Required)',
                    onSaved: (newValue) {
                      _enteredName = newValue!;
                    },
                  ),
                ],
              ),
            ),

            Spacer(), // Fills remaining space to push button to the bottom

            // Sign-Up button
            PrimaryButton(
              onPressed: _createAccount,
              backgroundColor: Theme.of(context).primaryColor,
              label: "Sign Up",
              horizontal: 140,
              vertical: 13,
            ),

            const SizedBox(height: 20),

            // Sign-in option with navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    Navigator.pop(context); // Navigate back to Sign-in screen
                  },
                  child: Text(
                    "Sign in",
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
