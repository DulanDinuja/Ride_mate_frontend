import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../models/ride_model.dart';

class RideRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  Future<List<RideModel>> searchRides({
    required String origin,
    required String destination,
    DateTime? date,
    String? genderFilter,
    double? minPrice,
    double? maxPrice,
  }) async {
    final response = await _dio.get('/rides/search', queryParameters: {
      'origin': origin,
      'destination': destination,
    });
    return (response.data as List).map((e) => RideModel.fromJson(e)).toList();
  }

  Future<void> createRide({
    required Map<String, dynamic> origin,
    required Map<String, dynamic> destination,
    required DateTime departureTime,
    required int availableSeats,
    required double pricePerSeat,
    required Map<String, dynamic> vehicle,
    String? genderPreference,
  }) async {
    await _dio.post('/rides', data: {
      'origin': origin,
      'destination': destination,
      'departureTime': departureTime.toIso8601String(),
      'availableSeats': availableSeats,
      'pricePerSeat': pricePerSeat,
      'vehicle': vehicle,
    });
  }

  Future<List<RideModel>> getMyRides(String userId, String status) async {
    final response = await _dio.get('/rides/user/$userId');
    return (response.data as List).map((e) => RideModel.fromJson(e)).toList();
  }
}
