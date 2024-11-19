import 'package:flutter/material.dart';
import 'package:green_oil/models/MyOrder.dart';
import 'package:green_oil/schedule_screen/schedule_screen.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order});

  final MyOrder order;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${order.arrivalDate.day}/${order.arrivalDate.month}/${order.arrivalDate.year}';
    return Column(
      children: [
        getOrderStatus(order, context),
        Card(
          elevation: 2,
          color: Theme.of(context).colorScheme.onPrimary,
          margin: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 5,
          ), // Space around the card
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            // Padding inside the card
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order ID
                buildDetailItem(
                  'Order ID',
                  order.orderID,
                  context,
                ),
                // Order Type
                buildDetailItem(
                  'Oil Type',
                  getOrderType(order),
                  context,
                ),

                // Oil Quantity and Points
                buildDetailItem(
                  'Estimated Quantity',
                  '${order.oilQuantity.toStringAsFixed(1)}L',
                  context,
                ),

                // Pickup Date
                buildDetailItem(
                  'Pickup Date',
                  formattedDate,
                  context,
                ),

                const SizedBox(height: 5),
                // View Details Link
                Container(
                  height: 40, // Adjust the height as needed
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      const ScheduleScreen().viewOrderDetails(context, order);
                    },
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

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

Widget getOrderStatus(MyOrder order, BuildContext context) {
  if (order.orderStatus == OrderStatus.processing) {
    return Row(
      children: [
        const SizedBox(width: 14),
        Icon(
          Icons.sync_rounded,
          color: Theme.of(context).disabledColor,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          "Processing",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).disabledColor,
          ),
        ),
      ],
    );
  } else if (order.orderStatus == OrderStatus.completed) {
    return Row(
      children: [
        const SizedBox(width: 14),
        Icon(
          Icons.check_circle_outline_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          "Completed",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  } else {
    return Row(
      children: [
        SizedBox(width: 14),
        Icon(
          Icons.cancel_outlined,
          color: Theme.of(context).colorScheme.error,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "Cancelled",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ],
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
    return "ERROR";
  }
}
