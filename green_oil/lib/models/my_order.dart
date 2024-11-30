enum OilType {
  motorOil,
  cookingOil,
  lubricating,
}

enum OrderStatus {
  pending,
  accepted,
  pickupScheduled,
  completed,
  cancelled,
}

class MyOrder {
  MyOrder({
    required this.oilType,
    required this.oilQuantity,
    required this.oilPrice,
    required this.arrivalDate,
    required this.orderStatus,
    required this.orderID,
    required this.location,
  });

  final String orderID;
  final OilType oilType;
  final double oilQuantity;
  final double oilPrice;
  final DateTime arrivalDate;
  final OrderStatus orderStatus;
  final Location location;
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() {
    return 'Latitude: $latitude - Longitude: $longitude';
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      latitude: map['latitude'].toDouble(),
      longitude: map['longitude'].toDouble(),
    );
  }
}
