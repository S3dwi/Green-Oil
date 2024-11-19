import 'package:flutter/material.dart';
import 'package:green_oil/models/MyOrder.dart';
import 'package:green_oil/schedule_screen/orders_list/order_item.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key, required this.orders});

  final List<MyOrder> orders;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (ctx, index) => OrderItem(order: orders[index]),
    );
  }
}
