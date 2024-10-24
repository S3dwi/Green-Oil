// import 'package:uuid/uuid.dart';

//const uuid = Uuid();

enum OilType { motorOil, cookingOil, lubricating }

enum OrderStatus { processing, completed, cancelled }

class Order {
  Order(
      {required this.oilType,
      required this.oilQuantity,
      required this.arrivalDate,
      required this.orderStatus,
      required this.orderID,
      required this.location});

  final String orderID;
  final OilType oilType;
  final double oilQuantity;
  final DateTime arrivalDate;
  final OrderStatus orderStatus;
  final Location location;
}

class Location {
  final String city;
  final double latitude;
  final double longitude;

  Location({
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  // Optional: You can add a method to generate a Google Maps link based on latitude and longitude
  String get googleMapsLink {
    return 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  }

  @override
  String toString() {
    return 'Location(city: $city, latitude: $latitude, longitude: $longitude)';
  }
}
