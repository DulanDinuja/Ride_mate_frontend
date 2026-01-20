import 'package:flutter/material.dart';
import '../../../data/models/kyc_model.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _userId;
  String? _error;
  UserProfile? _userProfile;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get userId => _userId;
  String? get error => _error;
  UserProfile? get userProfile => _userProfile;
  bool get canStartRides => _userProfile?.canStartRides == true && _userProfile?.kycStatus == KycStatus.approved;

  Future<bool> login({required String email, required String password}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Mock login logic - replace with actual API call
      await Future.delayed(const Duration(seconds: 2));
      _isAuthenticated = true;
      _userId = 'user123';
      _userProfile = UserProfile(
        id: 'user123',
        email: email,
        fullName: 'Sanjaya Kulathunga',
        canStartRides: true,
        kycStatus: KycStatus.approved,
      );
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
    required bool wantsToStartRides,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Mock registration logic - replace with actual API call
      await Future.delayed(const Duration(seconds: 2));
      _userId = 'user123';
      _userProfile = UserProfile(
        id: 'user123',
        email: email,
        fullName: fullName,
        phoneNumber: phoneNumber,
        canStartRides: wantsToStartRides,
        kycStatus: wantsToStartRides ? KycStatus.notSubmitted : KycStatus.approved,
      );
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

  void updateKycStatus(KycStatus status) {
    if (_userProfile != null) {
      _userProfile = _userProfile!.copyWith(kycStatus: status);
      notifyListeners();
    }
  }

  void logout() {
    _isAuthenticated = false;
    _userId = null;
    _userProfile = null;
    _error = null;
    notifyListeners();
  }
}

class UserProfile {
  final String id;
  final String email;
  final String fullName;
  final String? phoneNumber;
  final String? profilePhotoUrl;
  final bool canStartRides;
  final KycStatus kycStatus;

  UserProfile({
    required this.id,
    required this.email,
    required this.fullName,
    this.phoneNumber,
    this.profilePhotoUrl,
    required this.canStartRides,
    required this.kycStatus,
  });

  UserProfile copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? profilePhotoUrl,
    bool? canStartRides,
    KycStatus? kycStatus,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      canStartRides: canStartRides ?? this.canStartRides,
      kycStatus: kycStatus ?? this.kycStatus,
    );
  }
}