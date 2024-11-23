import 'package:flutter/material.dart';
import 'package:green_oil/home_screen/vertical_stepper.dart';

import 'package:green_oil/models/my_order.dart';
import 'package:green_oil/nav_bar.dart';
import 'package:green_oil/primary_button.dart';
import 'package:green_oil/schedule_screen/vertical.dart';

class TrackOrder extends StatelessWidget {
  const TrackOrder({
    super.key,
    required this.order,
  });

  final MyOrder order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true, // Ensures title is centered
        title: Column(
          children: [
            SizedBox(
              height: 37,
            ),
            Text(
              "Track Order",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 28,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 30,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Order ID: ${order.orderID.substring(order.orderID.length - 10)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: Vertical(
              currentStep: 3,
              stepLabels: [
                "Order Placed",
                "Order Accepted",
                "Pickup Scheduled",
                "Order Completed",
              ],
              stepSubtitles: [
                "Your order is being processed.",
                "Your order has been accepted.",
                "Your order is scheduled for pickup.",
                "Your order is complete.",
              ],
            ),
          ),
          const Spacer(),
          PrimaryButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NavBar(wantedPage: 0),
                ),
              );
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: 'Back To Home',
            vertical: 13,
            horizontal: 90,
          ),
          const SizedBox(
            height: 38,
          ),
        ],
      ),
    );
  }
}
