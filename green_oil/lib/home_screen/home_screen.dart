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
              height: 320, // Same vertical size as before
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/home_img.png', // Placeholder for the background image
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  const Positioned(
                    top: 60,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Be Recycled',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 0),
                        Text(
                          'Help the planet & earn \n rewards!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: 55,
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
                    bottom: 10,
                    left: 15,
                    right: 15,
                    child: RecycleButton(),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 50,
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
              height: 10,
            ),

            // "Your Points" button with full width and contents aligned to the left
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: PointButton(),
            ),

            // // Reduced space between "Your Points" and the buttons
            const SizedBox(
              height: 16,
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
                    label: 'Learn More',
                  ),

                  const SizedBox(width: 10), // Spacing between buttons

                  ClickableCards(
                    onPressed: () {},
                    icon: Icons.card_giftcard,
                    label: 'Your Rewards',
                  ),

                  const SizedBox(width: 8), // Spacing between buttons

                  ClickableCards(
                    onPressed: () {},
                    icon: Icons.explore,
                    label: 'Explore Rewards',
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
