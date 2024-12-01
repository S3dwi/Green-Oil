import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:green_oil/schedule_screen/vertical.dart';
import 'package:green_oil/models/my_order.dart';
import 'package:green_oil/primary_button.dart';
import 'package:green_oil/nav_bar.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({
    super.key,
    required this.order,
  });

  final MyOrder order;

  @override
  State<StatefulWidget> createState() {
    return _TrackOrderScreenState();
  }
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  int _currentStep = 0; // Initial step
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentStep = mapOrderStatusToStep(widget.order.orderStatus.name);
    fetchOrderStatus();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      fetchOrderStatus();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  // Maps an order status string to a corresponding step index for a progress tracker.
  // The function returns an integer representing the step based on the order status:
  // 0 for 'pending', 1 for 'accepted', 2 for 'pickup scheduled', and 3 for 'completed'.
  // Defaults to 0 for unknown statuses.
  int mapOrderStatusToStep(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 0;
      case 'accepted':
        return 1;
      case 'pickupscheduled':
        return 2;
      case 'completed':
        return 3;
      default:
        return 0; // Default step for unknown statuses
    }
  }

  // Fetches the order status from Firebase Realtime Database and maps it to a corresponding step index.
  // Returns an integer representing the order's current step: 0 for 'pending', 1 for 'accepted',
  // 2 for 'pickup scheduled', and 3 for 'completed'. Returns -1 if the status is unknown or an error occurs.

  Future<int> getOrderStatus() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        final databaseRef = FirebaseDatabase.instance
            .ref('requests/$userId/${widget.order.orderID}');
        final snapshot = await databaseRef.get();

        if (snapshot.exists) {
          final orderData = Map<String, dynamic>.from(snapshot.value as Map);
          final String status = orderData['order Status'] ?? '';

          switch (status.toLowerCase()) {
            case 'pending':
              return 0;
            case 'accepted':
              return 1;
            case 'pickupscheduled':
              return 2;
            case 'completed':
              return 3;
            default:
              return -1;
          }
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "An error occurred while fetching order status: $error",
            ),
          ),
        );
      }
    }
    return -1; // Default for unknown status or errors
  }

  // Fetches the current order status using `getOrderStatus` and updates the step in the UI.
  // The status is used to update the `_currentStep` to reflect the current progress of the order.
  void fetchOrderStatus() async {
    final int status = await getOrderStatus();
    if (mounted) {
      setState(() {
        _currentStep = status; // Update the step based on status
      });
    }
  }

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
                'Order ID: ${widget.order.orderID.substring(widget.order.orderID.length - 10)}',
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
              currentStep: _currentStep,
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
