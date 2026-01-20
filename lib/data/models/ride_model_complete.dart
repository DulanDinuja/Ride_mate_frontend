// Complete Ride Model with full lifecycle management
class RideModel {
  final String id;
  final String starterId;
  final String starterName;
  final String starterPhotoUrl;
  final double starterRating;
  final LocationModel origin;
  final LocationModel destination;
  final DateTime scheduledDateTime;
  final int totalSeats;
  final int availableSeats;
  final double totalCost;
  final double costPerSeat;
  final RideStatus status;
  final VehicleInfo vehicle;
  final List<RideParticipant> participants;
  final List<JoinRequest> joinRequests;
  final RidePreferences preferences;
  final String? notes;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String? cancellationReason;
  final double? actualDistance;
  final double? actualCost;

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
    required this.preferences,
    this.notes,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
    this.cancellationReason,
    this.actualDistance,
    this.actualCost,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'],
      starterId: json['starterId'],
      starterName: json['starterName'],
      starterPhotoUrl: json['starterPhotoUrl'] ?? '',
      starterRating: (json['starterRating'] ?? 0.0).toDouble(),
      origin: LocationModel.fromJson(json['origin']),
      destination: LocationModel.fromJson(json['destination']),
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
      preferences: RidePreferences.fromJson(json['preferences']),
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt']) : null,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
      cancellationReason: json['cancellationReason'],
      actualDistance: json['actualDistance']?.toDouble(),
      actualCost: json['actualCost']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'starterId': starterId,
      'starterName': starterName,
      'starterPhotoUrl': starterPhotoUrl,
      'starterRating': starterRating,
      'origin': origin.toJson(),
      'destination': destination.toJson(),
      'scheduledDateTime': scheduledDateTime.toIso8601String(),
      'totalSeats': totalSeats,
      'availableSeats': availableSeats,
      'totalCost': totalCost,
      'costPerSeat': costPerSeat,
      'status': status.name,
      'vehicle': vehicle.toJson(),
      'participants': participants.map((p) => p.toJson()).toList(),
      'joinRequests': joinRequests.map((r) => r.toJson()).toList(),
      'preferences': preferences.toJson(),
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'cancellationReason': cancellationReason,
      'actualDistance': actualDistance,
      'actualCost': actualCost,
    };
  }

  bool get canJoin => status == RideStatus.open && availableSeats > 0;
  bool get isUpcoming => scheduledDateTime.isAfter(DateTime.now());
  int get confirmedParticipants => participants.where((p) => p.status == ParticipantStatus.confirmed).length;
  double get actualCostPerSeat => actualCost != null ? actualCost! / (confirmedParticipants + 1) : costPerSeat;
}

// Location Model
class LocationModel {
  final String address;
  final double latitude;
  final double longitude;
  final String? placeId;
  final String? name;

  LocationModel({
    required this.address,
    required this.latitude,
    required this.longitude,
    this.placeId,
    this.name,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      placeId: json['placeId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'placeId': placeId,
      'name': name,
    };
  }

  String get displayName => name ?? address;
}

// Vehicle Info for rides
class VehicleInfo {
  final String make;
  final String model;
  final String color;
  final String licensePlate;
  final String type;

  VehicleInfo({
    required this.make,
    required this.model,
    required this.color,
    required this.licensePlate,
    required this.type,
  });

  factory VehicleInfo.fromJson(Map<String, dynamic> json) {
    return VehicleInfo(
      make: json['make'],
      model: json['model'],
      color: json['color'],
      licensePlate: json['licensePlate'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'make': make,
      'model': model,
      'color': color,
      'licensePlate': licensePlate,
      'type': type,
    };
  }

  String get displayName => '$color $make $model';
}

// Ride Participant
class RideParticipant {
  final String userId;
  final String name;
  final String photoUrl;
  final double rating;
  final DateTime joinedAt;
  final ParticipantStatus status;
  final double costShare;
  final bool hasReviewed;

  RideParticipant({
    required this.userId,
    required this.name,
    required this.photoUrl,
    required this.rating,
    required this.joinedAt,
    required this.status,
    required this.costShare,
    this.hasReviewed = false,
  });

  factory RideParticipant.fromJson(Map<String, dynamic> json) {
    return RideParticipant(
      userId: json['userId'],
      name: json['name'],
      photoUrl: json['photoUrl'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      joinedAt: DateTime.parse(json['joinedAt']),
      status: ParticipantStatus.values.firstWhere((e) => e.name == json['status']),
      costShare: json['costShare'].toDouble(),
      hasReviewed: json['hasReviewed'] ?? false,
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
      'costShare': costShare,
      'hasReviewed': hasReviewed,
    };
  }
}

// Join Request
class JoinRequest {
  final String id;
  final String userId;
  final String userName;
  final String userPhotoUrl;
  final double userRating;
  final String message;
  final DateTime requestedAt;
  final RequestStatus status;
  final String? responseMessage;
  final DateTime? respondedAt;

  JoinRequest({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userPhotoUrl,
    required this.userRating,
    required this.message,
    required this.requestedAt,
    required this.status,
    this.responseMessage,
    this.respondedAt,
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
      responseMessage: json['responseMessage'],
      respondedAt: json['respondedAt'] != null ? DateTime.parse(json['respondedAt']) : null,
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
      'responseMessage': responseMessage,
      'respondedAt': respondedAt?.toIso8601String(),
    };
  }
}

// Ride Preferences
class RidePreferences {
  final GenderPreference genderPreference;
  final bool smokingAllowed;
  final bool petsAllowed;
  final bool musicAllowed;
  final int maxDetourMinutes;
  final List<String> preferredAgeGroups;

  RidePreferences({
    required this.genderPreference,
    this.smokingAllowed = false,
    this.petsAllowed = false,
    this.musicAllowed = true,
    this.maxDetourMinutes = 10,
    this.preferredAgeGroups = const [],
  });

  factory RidePreferences.fromJson(Map<String, dynamic> json) {
    return RidePreferences(
      genderPreference: GenderPreference.values.firstWhere((e) => e.name == json['genderPreference']),
      smokingAllowed: json['smokingAllowed'] ?? false,
      petsAllowed: json['petsAllowed'] ?? false,
      musicAllowed: json['musicAllowed'] ?? true,
      maxDetourMinutes: json['maxDetourMinutes'] ?? 10,
      preferredAgeGroups: List<String>.from(json['preferredAgeGroups'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'genderPreference': genderPreference.name,
      'smokingAllowed': smokingAllowed,
      'petsAllowed': petsAllowed,
      'musicAllowed': musicAllowed,
      'maxDetourMinutes': maxDetourMinutes,
      'preferredAgeGroups': preferredAgeGroups,
    };
  }
}

// Enums
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
  completed,
  canceled
}

enum RequestStatus {
  pending,
  accepted,
  rejected
}

enum GenderPreference {
  any,
  maleOnly,
  femaleOnly
}