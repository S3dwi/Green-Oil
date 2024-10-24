import 'package:flutter/material.dart';
import 'package:green_oil/models/order.dart';
import 'package:green_oil/schedule_screen/schedule_screen.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${order.arrivalDate.day}/${order.arrivalDate.month}/${order.arrivalDate.year}';
    return Column(
      children: [
        getOrderStatus(order, context),
        Card(
          elevation: 2,
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.symmetric(
              horizontal: 14, vertical: 5), // Space around the card
          child: Padding(
            padding: const EdgeInsets.all(12.0), // Padding inside the card
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order ID Row

                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade100, blurRadius: 2)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Order ID',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                      Text(
                        order.orderID,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade100, blurRadius: 2)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Oil Type',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      Text(
                        getOrderType(order),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                //const SizedBox(height: 10),
                // Oil Quantity and Points
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade100, blurRadius: 2)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Estimated Quantity',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      Text(
                        '${order.oilQuantity.toStringAsFixed(1)}L',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade100, blurRadius: 2)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pickup Date',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ],
                  ),
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
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                //const SizedBox(height: 5),
                // Buttons: Invoice and Keep Track
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     OutlinedButton(
                //       onPressed: () {
                //         // Invoice action
                //       },
                //       style: OutlinedButton.styleFrom(
                //         side: BorderSide(
                //             color:
                //                 Theme.of(context).primaryColor), // Green border
                //         shape: RoundedRectangleBorder(
                //           borderRadius:
                //               BorderRadius.circular(8), // Rounded corners
                //         ),
                //         minimumSize: const Size(155, 45),
                //       ),
                //       child: Text(
                //         'Invoice',
                //         style: TextStyle(
                //             color: Theme.of(context).primaryColor,
                //             fontSize: 18,
                //             fontWeight: FontWeight.w900),
                //       ),
                //     ),
                //     ElevatedButton(
                //       onPressed: () {
                //         // Keep Track action
                //       },
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor:
                //             Theme.of(context).primaryColor, // Green background
                //         shape: RoundedRectangleBorder(
                //           borderRadius:
                //               BorderRadius.circular(8), // Rounded corners
                //         ),
                //         minimumSize: const Size(155, 45),
                //       ),
                //       child: const Text(
                //         'Keep Track',
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 18,
                //             fontWeight: FontWeight.w900),
                //       ),
                //     ),
                //   ],
                // ),
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

Widget getOrderStatus(Order order, BuildContext context) {
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
              color: Theme.of(context).disabledColor),
        ),
      ],
    );
  } else if (order.orderStatus == OrderStatus.completed) {
    return Row(
      children: [
        const SizedBox(width: 14),
        Icon(
          Icons.check_circle_outline_rounded,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          "Completed",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColor),
        ),
      ],
    );
  } else {
    return const Row(
      children: [
        SizedBox(width: 14),
        Icon(
          Icons.cancel_outlined,
          color: Colors.red,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "Cancelled",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w900, color: Colors.red),
        ),
      ],
    );
  }
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
