import 'package:flutter/material.dart';
import 'package:green_oil/home_screen/clickable_cards.dart';
import 'package:green_oil/home_screen/image_carousel.dart';
import 'package:green_oil/home_screen/point_button.dart';
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
            // Recycle Button section
            SizedBox(
              width: double.infinity,
              height: 280, // Same vertical size as before
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/home_img.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: -1,
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

            const SizedBox(
              height: 40,
            ),

            // Image Carousel
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15), // Same padding
              child: ImageCarousel(),
            ),

            const SizedBox(
              height: 20,
            ),

            // Rewards Center Title aligned to the left and closer to "Your Points" button
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rewards Center',
                  style: TextStyle(
                    fontSize: 20, // Same as before
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Reduced space between title and "Your Points"
            const SizedBox(
              height: 15,
            ),

            // "Your Points" button with full width and contents aligned to the left
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: PointButton(),
            ),

            // // Reduced space between "Your Points" and the buttons
            const SizedBox(
              height: 30,
            ),

            // // Three buttons taking up full width
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Row(
                children: [
                  ClickableCards(
                    onPressed: () {},
                    icon: Icons.info,
                    label: 'Learn more',
                  ),

                  const SizedBox(width: 10), // Spacing between buttons

                  ClickableCards(
                    onPressed: () {},
                    icon: Icons.card_giftcard,
                    label: 'Your rewards',
                  ),

                  const SizedBox(width: 10), // Spacing between buttons

                  ClickableCards(
                    onPressed: () {},
                    icon: Icons.explore,
                    label: 'Explore rewards',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
