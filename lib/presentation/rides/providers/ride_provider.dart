import 'package:flutter/material.dart';
import '../../../data/models/ride_model.dart';
import '../../../data/repositories/ride_repository.dart';

class RideProvider extends ChangeNotifier {
  final RideRepository _repository = RideRepository();
  List<RideModel> _rides = [];
  bool _isLoading = false;
  String? _error;

  List<RideModel> get rides => _rides;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> searchRides(String origin, String destination) async {
    _isLoading = true;
    notifyListeners();
    try {
      _rides = await _repository.searchRides(origin: origin, destination: destination);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
