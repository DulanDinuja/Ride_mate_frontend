import '../models/kyc_model.dart';

class RideModel {
  final String id;
  final String starterId;
  final String starterName;
  final String starterPhotoUrl;
  final double starterRating;
  final String origin;
  final String destination;
  final DateTime scheduledDateTime;
  final int totalSeats;
  final int availableSeats;
  final double totalCost;
  final double costPerSeat;
  final RideStatus status;
  final VehicleInfo vehicle;
  final List<RideParticipant> participants;
  final List<JoinRequest> joinRequests;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;

  RideModel({
    required this.id,
    required this.starterId,
    required this.starterName,
    required this.starterPhotoUrl,
    required this.starterRating,
    required this.origin,
    required this.destination,
    required this.scheduledDateTime,
    required this.totalSeats,
    required this.availableSeats,
    required this.totalCost,
    required this.costPerSeat,
    required this.status,
    required this.vehicle,
    required this.participants,
    required this.joinRequests,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'],
      starterId: json['starterId'],
      starterName: json['starterName'],
      starterPhotoUrl: json['starterPhotoUrl'] ?? '',
      starterRating: (json['starterRating'] ?? 0.0).toDouble(),
      origin: json['origin'],
      destination: json['destination'],
      scheduledDateTime: DateTime.parse(json['scheduledDateTime']),
      totalSeats: json['totalSeats'],
      availableSeats: json['availableSeats'],
      totalCost: json['totalCost'].toDouble(),
      costPerSeat: json['costPerSeat'].toDouble(),
      status: RideStatus.values.firstWhere((e) => e.name == json['status']),
      vehicle: VehicleInfo.fromJson(json['vehicle']),
      participants: (json['participants'] as List)
          .map((p) => RideParticipant.fromJson(p))
          .toList(),
      joinRequests: (json['joinRequests'] as List)
          .map((r) => JoinRequest.fromJson(r))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt']) : null,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'starterId': starterId,
      'starterName': starterName,
      'starterPhotoUrl': starterPhotoUrl,
      'starterRating': starterRating,
      'origin': origin,
      'destination': destination,
      'scheduledDateTime': scheduledDateTime.toIso8601String(),
      'totalSeats': totalSeats,
      'availableSeats': availableSeats,
      'totalCost': totalCost,
      'costPerSeat': costPerSeat,
      'status': status.name,
      'vehicle': vehicle.toJson(),
      'participants': participants.map((p) => p.toJson()).toList(),
      'joinRequests': joinRequests.map((r) => r.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }
}

class VehicleInfo {
  final String make;
  final String model;
  final String color;
  final String licensePlate;

  VehicleInfo({
    required this.make,
    required this.model,
    required this.color,
    required this.licensePlate,
  });

  factory VehicleInfo.fromJson(Map<String, dynamic> json) {
    return VehicleInfo(
      make: json['make'],
      model: json['model'],
      color: json['color'],
      licensePlate: json['licensePlate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'make': make,
      'model': model,
      'color': color,
      'licensePlate': licensePlate,
    };
  }
}

class RideParticipant {
  final String userId;
  final String name;
  final String photoUrl;
  final double rating;
  final DateTime joinedAt;
  final ParticipantStatus status;

  RideParticipant({
    required this.userId,
    required this.name,
    required this.photoUrl,
    required this.rating,
    required this.joinedAt,
    required this.status,
  });

  factory RideParticipant.fromJson(Map<String, dynamic> json) {
    return RideParticipant(
      userId: json['userId'],
      name: json['name'],
      photoUrl: json['photoUrl'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      joinedAt: DateTime.parse(json['joinedAt']),
      status: ParticipantStatus.values.firstWhere((e) => e.name == json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'photoUrl': photoUrl,
      'rating': rating,
      'joinedAt': joinedAt.toIso8601String(),
      'status': status.name,
    };
  }
}

class JoinRequest {
  final String id;
  final String userId;
  final String userName;
  final String userPhotoUrl;
  final double userRating;
  final String message;
  final DateTime requestedAt;
  final RequestStatus status;

  JoinRequest({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userPhotoUrl,
    required this.userRating,
    required this.message,
    required this.requestedAt,
    required this.status,
  });

  factory JoinRequest.fromJson(Map<String, dynamic> json) {
    return JoinRequest(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      userPhotoUrl: json['userPhotoUrl'] ?? '',
      userRating: (json['userRating'] ?? 0.0).toDouble(),
      message: json['message'] ?? '',
      requestedAt: DateTime.parse(json['requestedAt']),
      status: RequestStatus.values.firstWhere((e) => e.name == json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'userRating': userRating,
      'message': message,
      'requestedAt': requestedAt.toIso8601String(),
      'status': status.name,
    };
  }
}

enum RideStatus {
  open,
  full,
  started,
  completed,
  canceled
}

enum ParticipantStatus {
  confirmed,
  noShow,
  completed
}

enum RequestStatus {
  pending,
  accepted,
  rejected
}