import 'package:flutter/material.dart';
import 'package:green_oil/home_screen/recycle_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 310,
              child: Stack(
                children: [
                  Image.asset(
                    'images/home_img.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    left: 15,
                    right: 15,
                    child: RecycleButton(),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
