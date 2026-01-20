import 'kyc_model.dart';

// User Model with complete profile information
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
  final DrivingLicenseModel? drivingLicense;
  final UserStats stats;
  final List<ReviewModel> reviews;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final int reportCount;

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
    this.drivingLicense,
    required this.stats,
    this.reviews = const [],
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.reportCount = 0,
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
      drivingLicense: json['drivingLicense'] != null ? DrivingLicenseModel.fromJson(json['drivingLicense']) : null,
      stats: UserStats.fromJson(json['stats'] ?? {}),
      reviews: (json['reviews'] as List? ?? []).map((r) => ReviewModel.fromJson(r)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isActive: json['isActive'] ?? true,
      reportCount: json['reportCount'] ?? 0,
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
      'drivingLicense': drivingLicense?.toJson(),
      'stats': stats.toJson(),
      'reviews': reviews.map((r) => r.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive,
      'reportCount': reportCount,
    };
  }

  bool get canCreateRides => canStartRides && kycStatus == KycStatus.approved && vehicle != null && drivingLicense != null;
  double get averageRating => stats.averageRating;
  bool get isTrusted => stats.completedRides >= 5 && averageRating >= 4.0 && reportCount == 0;
}

// User Statistics
class UserStats {
  final int completedRides;
  final int canceledRides;
  final int ridesStarted;
  final int ridesJoined;
  final double averageRating;
  final int totalReviews;
  final int reportCount;
  final double totalDistanceTraveled;
  final double totalCostSaved;

  UserStats({
    required this.completedRides,
    required this.canceledRides,
    required this.ridesStarted,
    required this.ridesJoined,
    required this.averageRating,
    required this.totalReviews,
    required this.reportCount,
    required this.totalDistanceTraveled,
    required this.totalCostSaved,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      completedRides: json['completedRides'] ?? 0,
      canceledRides: json['canceledRides'] ?? 0,
      ridesStarted: json['ridesStarted'] ?? 0,
      ridesJoined: json['ridesJoined'] ?? 0,
      averageRating: (json['averageRating'] ?? 0.0).toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
      reportCount: json['reportCount'] ?? 0,
      totalDistanceTraveled: (json['totalDistanceTraveled'] ?? 0.0).toDouble(),
      totalCostSaved: (json['totalCostSaved'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completedRides': completedRides,
      'canceledRides': canceledRides,
      'ridesStarted': ridesStarted,
      'ridesJoined': ridesJoined,
      'averageRating': averageRating,
      'totalReviews': totalReviews,
      'reportCount': reportCount,
      'totalDistanceTraveled': totalDistanceTraveled,
      'totalCostSaved': totalCostSaved,
    };
  }
}

// Vehicle Model
class VehicleModel {
  final String id;
  final String make;
  final String model;
  final String year;
  final String color;
  final String licensePlate;
  final int seatCapacity;
  final String? photoUrl;
  final VehicleType type;
  final bool isVerified;

  VehicleModel({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.licensePlate,
    required this.seatCapacity,
    this.photoUrl,
    required this.type,
    this.isVerified = false,
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
      type: VehicleType.values.firstWhere((e) => e.name == json['type']),
      isVerified: json['isVerified'] ?? false,
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
      'type': type.name,
      'isVerified': isVerified,
    };
  }

  String get displayName => '$year $make $model';
}

// Driving License Model
class DrivingLicenseModel {
  final String id;
  final String licenseNumber;
  final DateTime issueDate;
  final DateTime expiryDate;
  final String issuingAuthority;
  final List<String> categories;
  final String? photoUrl;
  final bool isVerified;

  DrivingLicenseModel({
    required this.id,
    required this.licenseNumber,
    required this.issueDate,
    required this.expiryDate,
    required this.issuingAuthority,
    required this.categories,
    this.photoUrl,
    this.isVerified = false,
  });

  factory DrivingLicenseModel.fromJson(Map<String, dynamic> json) {
    return DrivingLicenseModel(
      id: json['id'],
      licenseNumber: json['licenseNumber'],
      issueDate: DateTime.parse(json['issueDate']),
      expiryDate: DateTime.parse(json['expiryDate']),
      issuingAuthority: json['issuingAuthority'],
      categories: List<String>.from(json['categories']),
      photoUrl: json['photoUrl'],
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'licenseNumber': licenseNumber,
      'issueDate': issueDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
      'issuingAuthority': issuingAuthority,
      'categories': categories,
      'photoUrl': photoUrl,
      'isVerified': isVerified,
    };
  }

  bool get isValid => DateTime.now().isBefore(expiryDate);
}

// Review Model
class ReviewModel {
  final String id;
  final String reviewerId;
  final String reviewerName;
  final String reviewerPhotoUrl;
  final String reviewedUserId;
  final String rideId;
  final double rating;
  final String comment;
  final List<String> tags;
  final DateTime createdAt;
  final ReviewType type;

  ReviewModel({
    required this.id,
    required this.reviewerId,
    required this.reviewerName,
    required this.reviewerPhotoUrl,
    required this.reviewedUserId,
    required this.rideId,
    required this.rating,
    required this.comment,
    this.tags = const [],
    required this.createdAt,
    required this.type,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      reviewerId: json['reviewerId'],
      reviewerName: json['reviewerName'],
      reviewerPhotoUrl: json['reviewerPhotoUrl'] ?? '',
      reviewedUserId: json['reviewedUserId'],
      rideId: json['rideId'],
      rating: json['rating'].toDouble(),
      comment: json['comment'],
      tags: List<String>.from(json['tags'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
      type: ReviewType.values.firstWhere((e) => e.name == json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reviewerId': reviewerId,
      'reviewerName': reviewerName,
      'reviewerPhotoUrl': reviewerPhotoUrl,
      'reviewedUserId': reviewedUserId,
      'rideId': rideId,
      'rating': rating,
      'comment': comment,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'type': type.name,
    };
  }
}

// Enums
enum VehicleType {
  sedan,
  suv,
  hatchback,
  van,
  pickup,
  other
}

enum ReviewType {
  asStarter,
  asPassenger
}