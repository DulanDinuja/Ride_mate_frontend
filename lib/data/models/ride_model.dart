class RideModel {
  final String id;
  final String driverId;
  final String origin;
  final String destination;
  final DateTime dateTime;
  final int availableSeats;
  final double price;

  RideModel({
    required this.id,
    required this.driverId,
    required this.origin,
    required this.destination,
    required this.dateTime,
    required this.availableSeats,
    required this.price,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'],
      driverId: json['driverId'],
      origin: json['origin'],
      destination: json['destination'],
      dateTime: DateTime.parse(json['dateTime']),
      availableSeats: json['availableSeats'],
      price: json['price'].toDouble(),
    );
  }
}