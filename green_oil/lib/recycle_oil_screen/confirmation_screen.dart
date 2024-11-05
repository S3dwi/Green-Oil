import 'package:flutter/material.dart';
import 'package:green_oil/nav_bar.dart';

class ConfirmationScreen extends StatelessWidget {
  // Add the orderId as a final property

  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/screen_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: 150),
                Image.asset(
                  'assets/images/Vector.png',
                  width: 225,
                  height: 225,
                ),
                const SizedBox(height: 0),
                const Text(
                  "Order has been placed \nsuccessfully!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your support helps the environment\nthrough recycling!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      //Navigate to Schedule screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavBar(
                            wantedPage: 1,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 75,
                      ),
                    ),
                    child: const Text(
                      "VIEW ORDERS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 150),
                TextButton(
                  onPressed: () {
                    //Navigate to Home Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavBar(
                          wantedPage: 0,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "BACK TO HOME",
                    style: TextStyle(
                      color: Color.fromARGB(0, 255, 255, 255),
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.green,
                      shadows: [
                        Shadow(
                          color: Colors
                              .green, // Match background color to create "gap"
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
        ],
      ),
    );
  }
}
