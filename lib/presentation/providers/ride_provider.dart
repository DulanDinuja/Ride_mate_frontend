import 'package:flutter/material.dart';
import '../../data/models/ride_model_complete.dart';

class RideProvider extends ChangeNotifier {
  List<RideModel> _rides = [];
  bool _isLoading = false;
  String? _error;

  List<RideModel> get rides => _rides;
  List<RideModel> get availableRides => _rides;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void createRide(RideModel ride) {
    _rides.add(ride);
    notifyListeners();
  }

  void searchRides(String from, String to) {
    // Minimal implementation - just notify listeners
    notifyListeners();
  }

  void loadNearbyRides(double lat, double lng, double radius) {
    // Minimal implementation
    notifyListeners();
  }

  void sortRidesByPrice({bool ascending = true}) {
    // Minimal implementation
    notifyListeners();
  }

  void sortRidesByTime({bool ascending = true}) {
    // Minimal implementation
    notifyListeners();
  }

  void sortRidesByRating({bool ascending = false}) {
    // Minimal implementation
    notifyListeners();
  }
}