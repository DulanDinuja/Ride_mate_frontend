import 'package:dio/dio.dart';
import '../models/user_model_complete.dart';
import '../models/ride_model_complete.dart';
import '../../core/constants/app_constants.dart';

class UserRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  // Authentication
  Future<UserModel> login(String email, String password) async {
    final response = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(response.data['user']);
  }

  Future<UserModel> register({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required bool canStartRides,
  }) async {
    final response = await _dio.post('/auth/register', data: {
      'email': email,
      'password': password,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'canStartRides': canStartRides,
    });
    return UserModel.fromJson(response.data['user']);
  }

  // Profile Management
  Future<UserModel> getUserProfile(String userId) async {
    final response = await _dio.get('/users/$userId');
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> updateProfile(String userId, Map<String, dynamic> updates) async {
    final response = await _dio.put('/users/$userId', data: updates);
    return UserModel.fromJson(response.data);
  }

  Future<String> uploadProfilePhoto(String userId, String imagePath) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imagePath),
      'userId': userId,
    });

    final response = await _dio.post('/users/upload-photo', data: formData);
    return response.data['photoUrl'];
  }

  // Vehicle Management
  Future<VehicleModel> addVehicle(String userId, VehicleModel vehicle) async {
    final response = await _dio.post('/users/$userId/vehicles', data: vehicle.toJson());
    return VehicleModel.fromJson(response.data);
  }

  Future<VehicleModel> updateVehicle(String userId, String vehicleId, VehicleModel vehicle) async {
    final response = await _dio.put('/users/$userId/vehicles/$vehicleId', data: vehicle.toJson());
    return VehicleModel.fromJson(response.data);
  }

  // Driving License Management
  Future<DrivingLicenseModel> addDrivingLicense(String userId, DrivingLicenseModel license) async {
    final response = await _dio.post('/users/$userId/driving-license', data: license.toJson());
    return DrivingLicenseModel.fromJson(response.data);
  }

  // Reviews
  Future<List<ReviewModel>> getUserReviews(String userId) async {
    final response = await _dio.get('/users/$userId/reviews');
    return (response.data as List).map((r) => ReviewModel.fromJson(r)).toList();
  }

  Future<ReviewModel> submitReview(ReviewModel review) async {
    final response = await _dio.post('/reviews', data: review.toJson());
    return ReviewModel.fromJson(response.data);
  }

  // Search Users
  Future<List<UserModel>> searchUsers(String query) async {
    final response = await _dio.get('/users/search', queryParameters: {'q': query});
    return (response.data as List).map((u) => UserModel.fromJson(u)).toList();
  }

  // Report User
  Future<void> reportUser(String userId, String reportedUserId, String reason) async {
    await _dio.post('/users/report', data: {
      'reporterId': userId,
      'reportedUserId': reportedUserId,
      'reason': reason,
    });
  }
}

class RideRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  // Ride Creation
  Future<RideModel> createRide(RideModel ride) async {
    final response = await _dio.post('/rides', data: ride.toJson());
    return RideModel.fromJson(response.data);
  }

  // Ride Search and Discovery
  Future<List<RideModel>> searchRides({
    required String origin,
    required String destination,
    DateTime? date,
    GenderPreference? genderFilter,
    double? minPrice,
    double? maxPrice,
    int? availableSeats,
  }) async {
    final queryParams = <String, dynamic>{
      'origin': origin,
      'destination': destination,
    };

    if (date != null) queryParams['date'] = date.toIso8601String();
    if (genderFilter != null) queryParams['genderFilter'] = genderFilter.name;
    if (minPrice != null) queryParams['minPrice'] = minPrice;
    if (maxPrice != null) queryParams['maxPrice'] = maxPrice;
    if (availableSeats != null) queryParams['availableSeats'] = availableSeats;

    final response = await _dio.get('/rides/search', queryParameters: queryParams);
    return (response.data as List).map((r) => RideModel.fromJson(r)).toList();
  }

  Future<List<RideModel>> getNearbyRides(double lat, double lng, double radiusKm) async {
    final response = await _dio.get('/rides/nearby', queryParameters: {
      'lat': lat,
      'lng': lng,
      'radius': radiusKm,
    });
    return (response.data as List).map((r) => RideModel.fromJson(r)).toList();
  }

  // User's Rides
  Future<List<RideModel>> getUserRides(String userId, {RideStatus? status}) async {
    final queryParams = <String, dynamic>{'userId': userId};
    if (status != null) queryParams['status'] = status.name;

    final response = await _dio.get('/rides/user', queryParameters: queryParams);
    return (response.data as List).map((r) => RideModel.fromJson(r)).toList();
  }

  Future<List<RideModel>> getStartedRides(String userId) async {
    final response = await _dio.get('/rides/started/$userId');
    return (response.data as List).map((r) => RideModel.fromJson(r)).toList();
  }

  Future<List<RideModel>> getJoinedRides(String userId) async {
    final response = await _dio.get('/rides/joined/$userId');
    return (response.data as List).map((r) => RideModel.fromJson(r)).toList();
  }

  // Ride Details
  Future<RideModel> getRideDetails(String rideId) async {
    final response = await _dio.get('/rides/$rideId');
    return RideModel.fromJson(response.data);
  }

  // Join Requests
  Future<JoinRequest> submitJoinRequest(String rideId, String userId, String message) async {
    final response = await _dio.post('/rides/$rideId/join-requests', data: {
      'userId': userId,
      'message': message,
    });
    return JoinRequest.fromJson(response.data);
  }

  Future<JoinRequest> respondToJoinRequest(String requestId, bool accept, String? message) async {
    final response = await _dio.put('/join-requests/$requestId/respond', data: {
      'accept': accept,
      'message': message,
    });
    return JoinRequest.fromJson(response.data);
  }

  Future<List<JoinRequest>> getRideJoinRequests(String rideId) async {
    final response = await _dio.get('/rides/$rideId/join-requests');
    return (response.data as List).map((r) => JoinRequest.fromJson(r)).toList();
  }

  // Ride Lifecycle Management
  Future<RideModel> startRide(String rideId) async {
    final response = await _dio.put('/rides/$rideId/start');
    return RideModel.fromJson(response.data);
  }

  Future<RideModel> completeRide(String rideId, {
    double? actualDistance,
    double? actualCost,
  }) async {
    final response = await _dio.put('/rides/$rideId/complete', data: {
      'actualDistance': actualDistance,
      'actualCost': actualCost,
    });
    return RideModel.fromJson(response.data);
  }

  Future<RideModel> cancelRide(String rideId, String reason) async {
    final response = await _dio.put('/rides/$rideId/cancel', data: {
      'reason': reason,
    });
    return RideModel.fromJson(response.data);
  }

  // Participant Management
  Future<void> removeParticipant(String rideId, String userId, String reason) async {
    await _dio.delete('/rides/$rideId/participants/$userId', data: {
      'reason': reason,
    });
  }

  Future<void> markParticipantNoShow(String rideId, String userId) async {
    await _dio.put('/rides/$rideId/participants/$userId/no-show');
  }

  // Real-time Updates
  Future<RideModel> getRideUpdates(String rideId) async {
    final response = await _dio.get('/rides/$rideId/updates');
    return RideModel.fromJson(response.data);
  }

  // Cost Calculation
  Future<Map<String, double>> calculateCostSplit(String rideId) async {
    final response = await _dio.get('/rides/$rideId/cost-split');
    return Map<String, double>.from(response.data);
  }
}