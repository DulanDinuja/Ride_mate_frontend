import 'kyc_model.dart';

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String? phoneNumber;
  final String? profilePhotoUrl;
  final String? profession;
  final String? bio;
  final bool canStartRides;
  final KycStatus kycStatus;
  final VehicleModel? vehicle;
  final UserStats stats;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.phoneNumber,
    this.profilePhotoUrl,
    this.profession,
    this.bio,
    required this.canStartRides,
    required this.kycStatus,
    this.vehicle,
    required this.stats,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      profilePhotoUrl: json['profilePhotoUrl'],
      profession: json['profession'],
      bio: json['bio'],
      canStartRides: json['canStartRides'] ?? false,
      kycStatus: KycStatus.values.firstWhere(
        (e) => e.name == json['kycStatus'],
        orElse: () => KycStatus.notSubmitted,
      ),
      vehicle: json['vehicle'] != null ? VehicleModel.fromJson(json['vehicle']) : null,
      stats: UserStats.fromJson(json['stats'] ?? {}),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'profilePhotoUrl': profilePhotoUrl,
      'profession': profession,
      'bio': bio,
      'canStartRides': canStartRides,
      'kycStatus': kycStatus.name,
      'vehicle': vehicle?.toJson(),
      'stats': stats.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  bool get canCreateRides => canStartRides && kycStatus == KycStatus.approved;
}

class UserStats {
  final int completedRides;
  final int canceledRides;
  final int ridesStarted;
  final double averageRating;
  final int totalReviews;
  final int reportCount;

  UserStats({
    required this.completedRides,
    required this.canceledRides,
    required this.ridesStarted,
    required this.averageRating,
    required this.totalReviews,
    required this.reportCount,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      completedRides: json['completedRides'] ?? 0,
      canceledRides: json['canceledRides'] ?? 0,
      ridesStarted: json['ridesStarted'] ?? 0,
      averageRating: (json['averageRating'] ?? 0.0).toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
      reportCount: json['reportCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completedRides': completedRides,
      'canceledRides': canceledRides,
      'ridesStarted': ridesStarted,
      'averageRating': averageRating,
      'totalReviews': totalReviews,
      'reportCount': reportCount,
    };
  }
}

class VehicleModel {
  final String id;
  final String make;
  final String model;
  final String year;
  final String color;
  final String licensePlate;
  final int seatCapacity;
  final String? photoUrl;

  VehicleModel({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.licensePlate,
    required this.seatCapacity,
    this.photoUrl,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      make: json['make'],
      model: json['model'],
      year: json['year'],
      color: json['color'],
      licensePlate: json['licensePlate'],
      seatCapacity: json['seatCapacity'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'make': make,
      'model': model,
      'year': year,
      'color': color,
      'licensePlate': licensePlate,
      'seatCapacity': seatCapacity,
      'photoUrl': photoUrl,
    };
  }
}