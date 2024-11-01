import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:green_oil/models/order.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${order.arrivalDate.day}/${order.arrivalDate.month}/${order.arrivalDate.year}';
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true, // Ensures title is centered
        title: const Column(
          children: [
            SizedBox(
              height: 38,
            ),
            Text(
              "Schedule",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 28,
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.end, // Align everything at the bottom
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Space evenly between Order Information and Customer Location
                  children: [
                    const Text(
                      'Order Information',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize
                          .min, // Align Icon and TextButton to the right
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.pin_drop,
                              color: Colors.green,
                              size: 24,
                            ),
                            const SizedBox(
                                width: 5), // Add spacing between icon and text
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    // Test with a simple URL
                                    final Uri uri = Uri.parse(
                                        order.location.googleMapsLink);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri,
                                          mode: LaunchMode
                                              .inAppWebView); // Opens the URL inside the app
                                    } else {
                                      // Show error message to the user using SnackBar
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  child: const Text(
                                    'Customer Location',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const Text(
              //         'Order Information',
              //         style: TextStyle(
              //             fontSize: 17,
              //             fontWeight: FontWeight.w900,
              //             color: Colors.black),
              //       ),
              //       Row(
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         children: [
              //           const Icon(
              //             Icons.pin_drop,
              //             color: Colors.green,
              //             size: 20,
              //           ),
              //           TextButton(
              //             onPressed: () {},
              //             child: const Text(
              //               'Customer Location',
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.w700,
              //                   color: Colors.black),
              //             ),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              Card(
                elevation: 2,
                color: Theme.of(context).cardColor,
                margin: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 5), // Space around the card
                child: Padding(
                  padding:
                      const EdgeInsets.all(10.0), // Padding inside the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order ID Row

                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 2),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 2),
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
                              'Order Status',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            Text(
                              getOrderStatus(order),
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      //const SizedBox(height: 10),
                      //const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 2),
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            Text(
                              getOrderType(order),
                              style: const TextStyle(
                                  fontSize: 15,
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
                            vertical: 6, horizontal: 2),
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            Text(
                              '${order.oilQuantity.toStringAsFixed(1)}L',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      // Arrival Date & Time Row
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 2),
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 2),
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
                              'Customer Location',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            Text(
                              order.location.city,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      // Arrival Date & Time Row

                      const SizedBox(height: 20),
                      //const SizedBox(height: 5),
                      // Buttons: Invoice and Keep Track
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              // Invoice action
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color: Theme.of(context)
                                      .primaryColor), // Green border
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8), // Rounded corners
                              ),
                              minimumSize: const Size(180, 50),
                            ),
                            child: Text(
                              'Invoice',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     // Keep Track action
                          //   },
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Theme.of(context)
                          //         .primaryColor, // Green background
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius:
                          //           BorderRadius.circular(8), // Rounded corners
                          //     ),
                          //     minimumSize: const Size(155, 45),
                          //   ),
                          //   child: const Text(
                          //     'Re-order',
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 18,
                          //         fontWeight: FontWeight.w900),
                          //   ),
                          // ),
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
      ),
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
    if (kDebugMode) {
      print("ERROR IN FETCHING ORDER TYPE");
    }
    return "ERROR";
  }
}

String getOrderStatus(Order order) {
  if (order.orderStatus == OrderStatus.processing) {
    return "Processing";
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
