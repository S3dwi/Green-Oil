import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:green_oil/schedule_screen/orders_list/orders_list.dart';
import 'package:green_oil/models/my_order.dart';

class OrderSwitcher extends StatefulWidget {
  const OrderSwitcher({super.key});

  @override
  State<OrderSwitcher> createState() {
    return _OrderSwitcherState();
  }
}

class _OrderSwitcherState extends State<OrderSwitcher> {
  List<MyOrder> _ongoingOrders = [];
  List<MyOrder> _historyOrders = [];
  int selectedIndex = 0;
  var _isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Fetch requests initially
    getUserRequests();

    // Set up a timer to call getUserRequests every 1 minute
    _timer = Timer.periodic(const Duration(minutes: 2), (timer) {
      getUserRequests();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  void getUserRequests() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        final databaseRef = FirebaseDatabase.instance.ref('requests/$userId');
        final snapshot = await databaseRef.get();

        if (snapshot.exists) {
          final List<MyOrder> ongoingOrders = [];
          final List<MyOrder> historyOrders = [];

          final data = Map<String, dynamic>.from(snapshot.value as Map);
          data.forEach((key, value) {
            final orderData = Map<String, dynamic>.from(value as Map);

            final MyOrder order = MyOrder(
              oilType: OilType.values.firstWhere(
                (e) =>
                    e.toString().split('.').last.toLowerCase() ==
                    orderData['oil Type'].toString().toLowerCase(),
                orElse: () => OilType.cookingOil, // Default value
              ),
              oilQuantity: double.parse(orderData['quantity'].toString()),
              oilPrice: double.parse(orderData['oil Price'].toString()),
              arrivalDate: DateTime.parse(orderData['arrival Date']),
              orderStatus: OrderStatus.values.firstWhere(
                (e) =>
                    e.toString().split('.').last.toLowerCase() ==
                    orderData['order Status'].toString().toLowerCase(),
                orElse: () => OrderStatus.pending, // Default value
              ),
              orderID: key,
              location: Location(
                latitude:
                    double.parse(orderData['location']['latitude'].toString()),
                longitude:
                    double.parse(orderData['location']['longitude'].toString()),
              ),
            );

            // Classify orders based on their status
            if (order.orderStatus == OrderStatus.completed ||
                order.orderStatus == OrderStatus.cancelled) {
              historyOrders.add(order);
            } else {
              ongoingOrders.add(order);
            }
          });

          setState(() {
            _ongoingOrders = ongoingOrders;
            _historyOrders = historyOrders;
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "An error occurred while fetching orders: $error",
            ),
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else if (selectedIndex == 0 && _ongoingOrders.isEmpty) {
      // Show specific message for Ongoing tab
      content = Center(
        child: Text(
          'No ongoing orders.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      );
    } else if (selectedIndex == 1 && _historyOrders.isEmpty) {
      // Show specific message for History tab
      content = Center(
          child: Text(
        'No completed or cancelled orders.',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ));
    } else {
      // Show the corresponding list based on the selected tab
      content = selectedIndex == 0
          ? OrdersList(orders: _ongoingOrders)
          : OrdersList(orders: _historyOrders);
    }

    return Column(
      children: [
        // Use a Stack to overlay buttons on the same vertical level
        Stack(
          alignment: Alignment.center,
          children: [
            // Unselected background layer (visible part of the unselected button)
            Positioned(
              child: Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(94, 36, 165, 79),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Change to "Ongoing" only if it's unselected
                        if (selectedIndex != 0) {
                          setState(() {
                            selectedIndex = 0;
                          });
                        }
                      },
                      child: Text(
                        'Ongoing',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Change to "History" only if it's unselected
                        if (selectedIndex != 1) {
                          setState(() {
                            selectedIndex = 1;
                          });
                        }
                      },
                      child: Text(
                        'History',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Selected button overlay
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: selectedIndex == 0
                  ? 0
                  : 175, // Adjust the position based on the selected button
              child: Container(
                width: 175,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    selectedIndex == 0 ? 'Ongoing' : 'History',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Wrap Expanded widget in Flexible or wrap the entire Column with Expanded
        Expanded(
          child: content,
        ),
      ],
    );
  }
}
