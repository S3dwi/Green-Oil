import 'package:flutter/material.dart';
import 'package:green_oil/models/my_order.dart';
import 'package:green_oil/schedule_screen/orders_list/order_item.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({
    super.key,
    required this.orders,
  });

  final List<MyOrder> orders;

  // Builds a list of order items using ListView.builder.
  // Each item in the list is an instance of the OrderItem widget, displaying an order.
  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (ctx, index) => OrderItem(
        order: orders[index],
      ),
    );
  }
}
