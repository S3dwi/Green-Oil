// order_process_screen.dart
import 'package:flutter/material.dart';
import 'package:green_oil/home_screen/vertical_stepper.dart';

class OrderProcessScreen extends StatelessWidget {
  const OrderProcessScreen({super.key});

  // order process screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 25,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "Order Process",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/icon/logo.png',
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalStepper(
                  currentStep: 4, // to shown that stepper all in green
                  totalSteps: 4,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      OrderProcessStep(
                        title: "Create a New Listing",
                        description:
                            "Specify the type of oil, quantity available, and preferred pickup date.",
                      ),
                      SizedBox(height: 24),
                      OrderProcessStep(
                        title: "Waiting for Buyer",
                        description:
                            "The listing is visible to potential buyers (recycling companies).",
                      ),
                      SizedBox(height: 24),
                      OrderProcessStep(
                        title: "Schedule Pickup",
                        description:
                            "Coordinate the pickup time and location with the selected buyer through the contact information provided by the buyer.",
                      ),
                      SizedBox(height: 24),
                      OrderProcessStep(
                        title: "Oil Pickup",
                        description: "The buyer collects the used oil.",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderProcessStep extends StatelessWidget {
  final String title;
  final String description;

  const OrderProcessStep({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
