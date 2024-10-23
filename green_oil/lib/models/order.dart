// import 'package:uuid/uuid.dart';

//const uuid = Uuid();

enum OilType { motorOil, cookingOil, lubricating }

enum OrderStatus { processing, completed, cancelled }

class Order {
  Order(
      {required this.oilType,
      required this.oilQuantity,
      required this.arrivalDate,
      required this.reward,
      required this.orderStatus,
      required this.orderID});

  final String orderID;
  final OilType oilType;
  final double oilQuantity;
  final DateTime arrivalDate;
  final String reward;
  final OrderStatus orderStatus;
}
