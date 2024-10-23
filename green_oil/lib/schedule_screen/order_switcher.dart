import 'package:flutter/material.dart';
import 'package:green_oil/models/order.dart';
import 'package:green_oil/schedule_screen/orders_list/orders_list.dart';

class OrderSwitcher extends StatefulWidget {
  const OrderSwitcher({super.key});

  @override
  State<OrderSwitcher> createState() {
    return _OrderSwitcherState();
  }
}

class _OrderSwitcherState extends State<OrderSwitcher> {
  final List<Order> _ongoingOrders = [
    Order(
        orderID: 'DS032402',
        oilType: OilType.cookingOil,
        oilQuantity: 10.5,
        arrivalDate: DateTime.now(),
        orderStatus: OrderStatus.processing,
        reward: "Ehsan Donation"),
    Order(
        orderID: 'DS000032',
        oilType: OilType.motorOil,
        oilQuantity: 5.6,
        arrivalDate: DateTime.now(),
        orderStatus: OrderStatus.processing,
        reward: "Ehsan Donation")
  ];
  final List<Order> _historyOrders = [
    Order(
        orderID: 'DS000041',
        oilType: OilType.motorOil,
        oilQuantity: 20.1,
        arrivalDate: DateTime.parse('2024-07-21 20:18'),
        orderStatus: OrderStatus.completed,
        reward: "Cash"),
    Order(
        orderID: 'DS000031',
        oilType: OilType.motorOil,
        oilQuantity: 5.7,
        arrivalDate: DateTime.parse('1969-04-10 20:18'),
        orderStatus: OrderStatus.completed,
        reward: "Ehsan Donation"),
    Order(
        orderID: 'DS000049',
        oilType: OilType.motorOil,
        oilQuantity: 7.4,
        arrivalDate: DateTime.parse('1969-02-29 20:18'),
        orderStatus: OrderStatus.cancelled,
        reward: "Ehsan Donation")
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                          color:
                              selectedIndex == 0 ? Colors.green : Colors.green,
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
                          color:
                              selectedIndex == 1 ? Colors.green : Colors.green,
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
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    selectedIndex == 0 ? 'Ongoing' : 'History',
                    style: const TextStyle(
                      color: Colors.white,
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
          child: selectedIndex == 0
              ? OrdersList(orders: _ongoingOrders)
              : OrdersList(orders: _historyOrders),
        ),
      ],
    );
  }
}
