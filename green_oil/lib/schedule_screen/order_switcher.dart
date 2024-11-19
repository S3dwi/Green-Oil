import 'package:flutter/material.dart';
import 'package:green_oil/models/MyOrder.dart';
import 'package:green_oil/schedule_screen/orders_list/orders_list.dart';

class OrderSwitcher extends StatefulWidget {
  const OrderSwitcher({super.key});

  @override
  State<OrderSwitcher> createState() {
    return _OrderSwitcherState();
  }
}

class _OrderSwitcherState extends State<OrderSwitcher> {
  final List<MyOrder> _ongoingOrders = [
    MyOrder(
      orderID: 'DS032402',
      oilType: OilType.cookingOil,
      oilQuantity: 10.5,
      arrivalDate: DateTime.now(),
      orderStatus: OrderStatus.processing,
      location:
          Location(city: 'Jeddah', latitude: 21.735611, longitude: 39.283458),
    ),
    MyOrder(
      orderID: 'DS000032',
      oilType: OilType.motorOil,
      oilQuantity: 5.6,
      arrivalDate: DateTime.now(),
      orderStatus: OrderStatus.processing,
      location:
          Location(city: 'Makkah', latitude: 21.381705, longitude: 39.799716),
    )
  ];
  final List<MyOrder> _historyOrders = [
    MyOrder(
      orderID: 'DS000041',
      oilType: OilType.motorOil,
      oilQuantity: 20.1,
      arrivalDate: DateTime.parse('2024-07-21 20:18'),
      orderStatus: OrderStatus.completed,
      location:
          Location(city: 'Riyadh', latitude: 24.677880, longitude: 46.718974),
    ),
    MyOrder(
      orderID: 'DS000031',
      oilType: OilType.motorOil,
      oilQuantity: 5.7,
      arrivalDate: DateTime.parse('1969-04-10 20:18'),
      orderStatus: OrderStatus.completed,
      location:
          Location(city: 'Tabuk', latitude: 28.391721, longitude: 36.579294),
    ),
    MyOrder(
      orderID: 'DS000049',
      oilType: OilType.motorOil,
      oilQuantity: 7.4,
      arrivalDate: DateTime.parse('1999-02-29 20:18'),
      orderStatus: OrderStatus.cancelled,
      location:
          Location(city: 'Jeddah', latitude: 22.735891, longitude: 39.283451),
    )
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
            const SizedBox(
              height: 70,
            )
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
