import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:green_oil/recycle_oil_screen/step_progress_indicator.dart';
import 'package:green_oil/recycle_oil_screen/confirmation_screen.dart';
import 'package:green_oil/recycle_oil_screen/recycle_oil.dart';
import 'package:green_oil/models/my_order.dart';
import 'package:green_oil/auth_button.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({
    super.key,
    required this.order,
    required this.currentStep,
  });

  final int currentStep;
  final MyOrder order;

  @override
  State<StatefulWidget> createState() {
    return _OrderSummaryState();
  }
}

class _OrderSummaryState extends State<OrderSummary> {
  bool _isLoading = false;

  // Fetches user information from Firestore using the provided [userId].
  // Returns a map with the user's email, name, company, phone number, and image URL.
  Future<Map<String, String>> fetchUserInfo(String userId) async {
    final userDoc =
        FirebaseFirestore.instance.collection('provider').doc(userId);
    final snapshot = await userDoc.get();

    final data = snapshot.data()!;
    return {
      'Email': data['Email'] ?? '',
      'Name': data['Name'] ?? '',
      'Company Name': data['Company Name'] ?? '',
      'Phone': data['Phone'] ?? '',
      'image_url': data['image_url'] ?? '',
    };
  }

  // Submits a recycling request by saving order details to Firebase Realtime Database.
  // It fetches user information from Firestore, constructs the order data, and stores it
  // under a unique request ID. The request status is set to "pending".
  void _submitRecyclingRequest() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      setState(() {
        _isLoading = true;
      });

      final databaseRef = FirebaseDatabase.instance.ref('requests/$userId');
      final newRequestRef = databaseRef.push();

      try {
        // Fetch user information from Firestore
        final userInfo = await fetchUserInfo(userId);

        // Submit the request
        await newRequestRef.set({
          'order Status': 'pending',
          'oil Type': getOrderType(widget.order),
          'quantity': widget.order.oilQuantity.toString(),
          'oil Price': widget.order.oilPrice.toString(),
          'arrival Date': DateFormat('yyyy-MM-dd')
              .format(widget.order.arrivalDate)
              .toString(),
          'location': {
            'latitude': widget.order.location.latitude,
            'longitude': widget.order.location.longitude,
          },
          'Provider Info': userInfo,
        });
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ConfirmationScreen(),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to submit recycling request: $e'),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false; // Stop loading
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${widget.order.arrivalDate.day}/${widget.order.arrivalDate.month}/${widget.order.arrivalDate.year}';
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0), // Adjust height if needed
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: StepProgressIndicator(
              currentStep: widget.currentStep,
              totalSteps: RecycleOil.totalSteps,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 25,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 0,
            ), // Adjust top padding as needed
            child: Align(
              alignment: Alignment.center, // Keeps title in the center
              child: Text(
                RecycleOil.stepTitles[widget.currentStep],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 40),
          Card(
            elevation: 2,
            color: Theme.of(context).colorScheme.onPrimary,
            margin: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 5,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Oil Type
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8, // Slightly increased vertical padding
                      horizontal: 6, // Slightly increased horizontal padding
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Oil Type',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Text(
                          getOrderType(widget.order),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                      thickness: 1.2,
                      height: 10), // More space and thicker line

                  // Estimated Quantity
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Estimated Quantity',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Text(
                          '${widget.order.oilQuantity.toStringAsFixed(1)}L',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1.2, height: 10),

                  // Oil Price
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Oil Price',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Text(
                          '${widget.order.oilPrice.toStringAsFixed(1)} SR',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1.2, height: 10),

                  // Company Location
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Company Location',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(
                          width: 90,
                        ),
                        Expanded(
                          child: Text(
                            widget.order.location.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1.2, height: 10),

                  // Pickup Date
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pickup Date',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Spacer(),

          // Next Button
          AuthButton(
            onPressed: _isLoading ? () {} : _submitRecyclingRequest,
            vertical: _isLoading ? 15 : 13,
            horizontal: _isLoading ? 165 : 91.38,
            child: _isLoading
                ? SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                : Text(
                    'SUBMIT ORDER',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  String getOrderType(MyOrder order) {
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
