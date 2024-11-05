import 'package:flutter/material.dart';
import 'package:green_oil/nav_bar.dart';
import 'package:green_oil/primary_button.dart';
import 'package:green_oil/sign_in_screen/sign_textfield.dart';
import 'package:green_oil/sign_up_screen/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

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
              "Sign in",
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
            // Email Address textField
            SignTextfield(
              label: "Email Address",
              controller: emailController,
              obscureText: false,
            ),

            const SizedBox(height: 20),
            // password textField
            SignTextfield(
              label: "Password",
              controller: passwordController,
              obscureText: true,
            ),

            const SizedBox(height: 15),
            // forgot password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Forgot Passwords?",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Spacer(flex: 1),
            // sign in button
            PrimaryButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => NavBar(
                      wantedPage: 0,
                    ),
                  ),
                );
              },
              backgroundColor: Theme.of(context).primaryColor,
              label: "Sign in",
              horizontal: 145,
              vertical: 13,
            ),

            const SizedBox(height: 20),
            // sign up
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
                    // navigate to sign up screen
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
