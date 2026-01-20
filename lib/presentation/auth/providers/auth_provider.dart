import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _userId;
  String? _error;
  bool _isKycVerified = false;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get userId => _userId;
  String? get error => _error;
  bool get isKycVerified => _isKycVerified;

  Future<bool> login({required String email, required String password}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Mock login logic - replace with actual API call
      await Future.delayed(const Duration(seconds: 2));
      _isAuthenticated = true;
      _userId = 'user123';
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Login failed';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String phoneNumber,
    required String email,
    required String password,
    required String fullName,
    required List<String> roles,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Mock registration logic - replace with actual API call
      await Future.delayed(const Duration(seconds: 2));
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Registration failed';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void setKycVerified(bool verified) {
    _isKycVerified = verified;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _userId = null;
    _error = null;
    _isKycVerified = false;
    notifyListeners();
  }
}