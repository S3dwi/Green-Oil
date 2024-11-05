import 'package:flutter/material.dart';
import 'package:green_oil/models/order.dart';
import 'package:green_oil/primary_button.dart';
import 'package:green_oil/recycle_oil_screen/confirmation_screen.dart';
import 'package:green_oil/recycle_oil_screen/recycle_oil.dart';
import 'package:green_oil/recycle_oil_screen/step_progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary(
      {super.key, required this.order, required this.currentStep});

  final int currentStep;
  final Order order;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${order.arrivalDate.day}/${order.arrivalDate.month}/${order.arrivalDate.year}';
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          RecycleOil.stepTitles[currentStep],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: StepProgressIndicator(
              currentStep: currentStep,
              totalSteps: RecycleOil.totalSteps,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Card(
                elevation: 2,
                color: Theme.of(context).cardColor,
                margin: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 5), // Space around the card
                child: Padding(
                  padding:
                      const EdgeInsets.all(12.0), // Padding inside the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade100, blurRadius: 2)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Oil Type',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            Text(
                              getOrderType(order),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      //const SizedBox(height: 10),
                      // Oil Quantity and Points
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade100, blurRadius: 2)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Estimated Quantity',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            Text(
                              '${order.oilQuantity.toStringAsFixed(1)}L',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade100, blurRadius: 2)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Company Location',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Test with a simple URL
                                final Uri uri =
                                    Uri.parse(order.location.googleMapsLink);
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(uri,
                                      mode: LaunchMode
                                          .inAppWebView); // Opens the URL inside the app
                                } else {
                                  // Show error message to the user using SnackBar
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Could not launch url'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets
                                    .zero, // Remove the default padding
                                minimumSize: const Size(0,
                                    0), // Set the minimum size to 0 to avoid extra space
                                tapTargetSize: MaterialTapTargetSize
                                    .shrinkWrap, // Shrink the tap target size
                                alignment: Alignment
                                    .centerLeft, // Align the text to the left within the button// Ensure button has no minimum size
                              ),
                              child: Text(
                                order.location.city,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade100, blurRadius: 2)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Pickup Date',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 400,
              ),
              // Next Button
              PrimaryButton(
                onPressed: () {
                  //Navigate to OrderSummary and pass the order object
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmationScreen(),
                    ),
                  );
                },
                backgroundColor: Theme.of(context).primaryColor,
                label: "SUBMIT ORDER",
                vertical: 13,
                horizontal: 91,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getOrderType(Order order) {
    if (order.oilType == OilType.cookingOil) {
      return "Cooking Oil";
    } else if (order.oilType == OilType.motorOil) {
      return "Motor Oil";
    } else if (order.oilType == OilType.lubricating) {
      return "Lubricating Oil";
    } else {
      return "ERROR";
    }
  }
}
