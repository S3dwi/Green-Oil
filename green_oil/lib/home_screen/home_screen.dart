import 'package:flutter/material.dart';
import 'package:green_oil/home_screen/image_carousel.dart';
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
            // Image Carousel
            const Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 25, 15), // Same padding
              child: ImageCarousel(),
            ),
            const SizedBox(
              height: 10,
            ),
            // Rewards Center Title aligned to the left and closer to "Your Points" button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rewards Center',
                  style: TextStyle(
                    fontSize: 18, // Same as before
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
                height: 10), // Reduced space between title and "Your Points"

            // "Your Points" button with full width and contents aligned to the left
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(12),
              width: double.infinity, // Full width of the screen
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.5), // Increased shadow opacity
                    spreadRadius: 4, // Increased spread radius
                    blurRadius: 8, // Increased blur radius
                    offset: const Offset(0, 4), // Adjusted shadow position
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.eco, // Leaf icon
                    color: Colors.green,
                    size: 35, // Increased icon size
                  ),
                  const SizedBox(
                      width: 10), // Spacing between the icon and the text
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Aligns text to the left
                    children: const [
                      Text(
                        'Your Points',
                        style: TextStyle(
                          fontSize: 14, // Slightly larger for emphasis
                          fontWeight: FontWeight.bold, // Bold black text
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                          height: 2), // Reduced space between text and points
                      Text(
                        '20/200', // Example points
                        style: TextStyle(
                          fontSize: 22, // Larger points text
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
                height:
                    10), // Reduced space between "Your Points" and the buttons

            // Three buttons taking up full width
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildRewardButton(
                      context,
                      'Learn more',
                      Icons.info,
                      () {
                        // Add functionality here
                      },
                    ),
                  ),
                  const SizedBox(width: 10), // Spacing between buttons
                  Expanded(
                    child: _buildRewardButton(
                      context,
                      'Your rewards',
                      Icons.card_giftcard,
                      () {
                        // Add functionality here
                      },
                    ),
                  ),
                  const SizedBox(width: 10), // Spacing between buttons
                  Expanded(
                    child: _buildRewardButton(
                      context,
                      'Explore rewards',
                      Icons.explore,
                      () {
                        // Add functionality here
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build each rectangular reward button with bigger icons but smaller vertical size
  Widget _buildRewardButton(BuildContext context, String label, IconData icon,
      VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding:
            const EdgeInsets.symmetric(vertical: 10), // Reduced vertical size
        backgroundColor: Colors.white, // Same button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded edges
        ),
        shadowColor: Colors.grey.withOpacity(0.3), // Shadow color
        elevation: 5, // Shadow elevation
      ),
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 28, // Same larger icon size
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13, // Slightly increased font size
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
