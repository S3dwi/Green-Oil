import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:green_oil/schedule_screen/invoice_screen.dart';
import 'package:green_oil/models/my_order.dart';
import 'package:green_oil/schedule_screen/track_order_screen.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    super.key,
    required this.order,
  });

  final MyOrder order;

  Widget buildDetailItem(String label, String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${order.arrivalDate.day}/${order.arrivalDate.month}/${order.arrivalDate.year}';
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true, // Ensures title is centered
        title: Column(
          children: [
            SizedBox(
              height: 38,
            ),
            Text(
              "Schedule",
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
      body: SingleChildScrollView(
        child: Column(
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
                  'Order Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 2,
              color: Theme.of(context).colorScheme.onPrimary,
              margin: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 5,
              ), // Space around the card
              child: Padding(
                padding: const EdgeInsets.all(10.0), // Padding inside the card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order ID
                    buildDetailItem(
                      'Order ID',
                      order.orderID.substring(order.orderID.length - 10),
                      context,
                    ),
                    Divider(),
                    // Order Status
                    buildDetailItem(
                      'Order Status',
                      getOrderStatus(order),
                      context,
                    ),
                    Divider(),
                    // Oil Type
                    buildDetailItem(
                      'Oil Type',
                      getOrderType(order),
                      context,
                    ),
                    Divider(),
                    // Oil Quantity
                    buildDetailItem(
                      'Estimated Quantity',
                      '${order.oilQuantity.toStringAsFixed(1)}L',
                      context,
                    ),
                    Divider(),
                    // Oil Price
                    buildDetailItem(
                      'Oil Price',
                      '${order.oilPrice.toStringAsFixed(1)} SR',
                      context,
                    ),
                    Divider(),
                    // Arrival Date & Time
                    buildDetailItem(
                      'Pickup Date',
                      formattedDate,
                      context,
                    ),
                    Divider(),
                    // Customer Location
                    buildDetailItem(
                      'Customer Location',
                      order.location.city,
                      context,
                    ),
                    Divider(),
                    const SizedBox(height: 20),

                    // Buttons: Invoice and Keep Track
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed:
                              order.orderStatus == OrderStatus.completed ||
                                      order.orderStatus == OrderStatus.cancelled
                                  ? () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              InvoiceScreen(order: order),
                                        ),
                                      );
                                    }
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary, // Always keep the same color
                            disabledBackgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5), // Same color when disabled
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(155, 50),
                          ),
                          child: Opacity(
                            opacity: order.orderStatus ==
                                        OrderStatus.completed ||
                                    order.orderStatus == OrderStatus.cancelled
                                ? 1.0
                                : 0.5, // Semi-transparent text if disabled
                            child: Text(
                              'Invoice',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: order.orderStatus ==
                                      OrderStatus.completed ||
                                  order.orderStatus == OrderStatus.cancelled
                              ? null
                              : () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TrackOrderScreen(
                                        order: order,
                                      ),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary, // Always keep the same color
                            disabledBackgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(180, 50),
                          ),
                          child: Opacity(
                            opacity: order.orderStatus ==
                                        OrderStatus.completed ||
                                    order.orderStatus == OrderStatus.cancelled
                                ? 0.5
                                : 1.0, // Semi-transparent text if disabled
                            child: Text(
                              'Track Order',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
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

String getOrderType(MyOrder order) {
  if (order.oilType == OilType.cookingOil) {
    return "Cooking Oil";
  } else if (order.oilType == OilType.motorOil) {
    return "Motor Oil";
  } else if (order.oilType == OilType.lubricating) {
    return "Lubricating Oil";
  } else {
    if (kDebugMode) {
      print("ERROR IN FETCHING ORDER TYPE");
    }
    return "ERROR";
  }
}

String getOrderStatus(MyOrder order) {
  if (order.orderStatus == OrderStatus.pending) {
    return "Pending";
  } else if (order.orderStatus == OrderStatus.accepted) {
    return "Order Accepted";
  } else if (order.orderStatus == OrderStatus.pickupScheduled) {
    return "Pickup Scheduled";
  } else if (order.orderStatus == OrderStatus.completed) {
    return "Completed";
  } else if (order.orderStatus == OrderStatus.cancelled) {
    return "Cancelled";
  } else {
    if (kDebugMode) {
      print("ERROR IN FETCHING ORDER STATUS");
    }
    return "ERROR";
  }
}
