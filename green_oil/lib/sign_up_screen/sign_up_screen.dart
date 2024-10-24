import 'package:flutter/material.dart';
import 'package:green_oil/primary_button.dart';
import 'package:green_oil/sign_in_screen/sign_in_screen.dart';
import 'package:green_oil/sign_in_screen/sign_textfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // logo
            Image.asset(
              "assets/icon/logo.png",
              width: 60,
            ),

            const SizedBox(height: 8),
            // title
            Text(
              "Create Account",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 3),
            // welcome back
            Text(
              "Be Recycled by join us today!",
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 50),
            // Company Name textField
            SignTextfield(
              label: "Company Name (Required)",
              controller: emailController,
              obscureText: false,
            ),

            const SizedBox(height: 15),
            // Contact Person textField
            SignTextfield(
              label: "Contact Person (Required)",
              controller: passwordController,
              obscureText: false,
            ),

            const SizedBox(height: 15),
            // Email Address textField
            SignTextfield(
              label: "Email Address (Required)",
              controller: emailController,
              obscureText: false,
            ),

            const SizedBox(height: 15),
            // Email Address textField
            SignTextfield(
              label: "Phone Number (Required)",
              controller: emailController,
              obscureText: false,
            ),

            const SizedBox(height: 15),
            // Email Address textField
            SignTextfield(
              label: "Business Address (Opitonal)",
              controller: emailController,
              obscureText: false,
            ),

            Spacer(),
            // sign in button

            PrimaryButton(
              onPressed: () {
                // TODO: validate inputs and sign up user
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              },
              backgroundColor: Theme.of(context).primaryColor,
              label: "Sign Up",
              horizontal: 140,
              vertical: 13,
            ),

            const SizedBox(height: 20),
            // sign up
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
                    Navigator.pop(context);
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
