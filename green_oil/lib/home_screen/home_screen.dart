import 'package:flutter/material.dart';
import 'package:green_oil/home_screen/clickable_cards.dart';
import 'package:green_oil/home_screen/image_carousel.dart';
import 'package:green_oil/home_screen/new_location.dart';
import 'package:green_oil/home_screen/recycle_button.dart';
import 'package:green_oil/recycle_oil_screen/recycle_oil.dart';
import 'package:green_oil/home_screen/faqs_screen.dart';
import 'package:green_oil/home_screen/usage_policy_screen.dart';
import 'package:green_oil/home_screen/order_process_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void recycleOil(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RecycleOil(
          currentStep: 0,
        ),
      ),
    );
  }

  // method to open the NewExpense page in Bottom sheet
  void _openAddExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewLocation(),
    );
  }

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
                  Positioned(
                    top: 60,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Be Recycled',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 0),
                        Text(
                          'Help the planet & enjoy \nvaluable benefits!',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
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
                      height: 58,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Theme.of(context).colorScheme.primary,
                              size: 30,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: const Text(
                                'Jeddah - Alrabwah 23223, Bin Khalid Alansari, Near Albaik Almarwah branch 6977',
                                style: TextStyle(fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _openAddExpense(context);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Theme.of(context).shadowColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(), //create line to separate between the components
            const SizedBox(
              height: 20,
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15), // Same padding
              child: RecycleButton(
                onRecycleOil: () {
                  recycleOil(context);
                },
              ),
            ),

            const SizedBox(
              height: 32,
            ),

            // Image Carousel
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15), // Same padding
              child: ImageCarousel(),
            ),

            const SizedBox(
              height: 16,
            ),

            // Title for the clickable cards section
            const Padding(
              padding: EdgeInsets.fromLTRB(
                  24.0, 0.0, 0.0, 10.0), // Add spacing below the title
              child: Align(
                alignment:
                    Alignment.centerLeft, // Explicitly align title to the left
                child: Text(
                  'Discover Green Oil',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // // Three buttons taking up full width
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Row(
                children: [
                  ClickableCards(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FAQScreen(),
                        ),
                      );
                    },
                    icon: Icons.question_answer,
                    label: 'FAQs',
                  ),

                  const SizedBox(width: 10), // Spacing between buttons

                  ClickableCards(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => OrderProcessScreen(),
                        ),
                      );
                    },
                    icon: Icons.checklist_sharp,
                    label: 'Order Process',
                  ),

                  const SizedBox(width: 8), // Spacing between buttons

                  ClickableCards(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UsagePolicyScreen(),
                        ),
                      );
                    },
                    icon: Icons.article_outlined,
                    label: 'Usage Policy',
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
