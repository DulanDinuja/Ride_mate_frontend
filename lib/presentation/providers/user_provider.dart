import 'package:flutter/material.dart';
import '../../data/models/user_model_complete.dart';
import '../../data/models/ride_model_complete.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/models/kyc_model.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _repository = UserRepository();
  
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;
  List<ReviewModel> _userReviews = [];

  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<ReviewModel> get userReviews => _userReviews;
  bool get isAuthenticated => _currentUser != null;
  bool get canStartRides => _currentUser?.canCreateRides ?? false;

  // Authentication
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      _currentUser = await _repository.login(email, password);
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required bool canStartRides,
  }) async {
    _setLoading(true);
    try {
      _currentUser = await _repository.register(
        email: email,
        password: password,
        fullName: fullName,
        phoneNumber: phoneNumber,
        canStartRides: canStartRides,
      );
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void logout() {
    _currentUser = null;
    _userReviews = [];
    _error = null;
    notifyListeners();
  }

  // Profile Management
  Future<bool> updateProfile(Map<String, dynamic> updates) async {
    if (_currentUser == null) return false;
    
    _setLoading(true);
    try {
      _currentUser = await _repository.updateProfile(_currentUser!.id, updates);
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> uploadProfilePhoto(String imagePath) async {
    if (_currentUser == null) return false;
    
    _setLoading(true);
    try {
      final photoUrl = await _repository.uploadProfilePhoto(_currentUser!.id, imagePath);
      await updateProfile({'profilePhotoUrl': photoUrl});
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Vehicle Management
  Future<bool> addVehicle(VehicleModel vehicle) async {
    if (_currentUser == null) return false;
    
    _setLoading(true);
    try {
      final newVehicle = await _repository.addVehicle(_currentUser!.id, vehicle);
      _currentUser = _currentUser!.copyWith(vehicle: newVehicle);
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Driving License Management
  Future<bool> addDrivingLicense(DrivingLicenseModel license) async {
    if (_currentUser == null) return false;
    
    _setLoading(true);
    try {
      final newLicense = await _repository.addDrivingLicense(_currentUser!.id, license);
      _currentUser = _currentUser!.copyWith(drivingLicense: newLicense);
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Reviews
  Future<void> loadUserReviews([String? userId]) async {
    final targetUserId = userId ?? _currentUser?.id;
    if (targetUserId == null) return;
    
    _setLoading(true);
    try {
      _userReviews = await _repository.getUserReviews(targetUserId);
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> submitReview(ReviewModel review) async {
    _setLoading(true);
    try {
      await _repository.submitReview(review);
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // KYC Status Update
  void updateKycStatus(KycStatus status) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(kycStatus: status);
      notifyListeners();
    }
  }

  // Helper Methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}

// Extension for UserModel copyWith
extension UserModelCopyWith on UserModel {
  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? profilePhotoUrl,
    String? profession,
    String? bio,
    bool? canStartRides,
    KycStatus? kycStatus,
    VehicleModel? vehicle,
    DrivingLicenseModel? drivingLicense,
    UserStats? stats,
    List<ReviewModel>? reviews,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    int? reportCount,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      profession: profession ?? this.profession,
      bio: bio ?? this.bio,
      canStartRides: canStartRides ?? this.canStartRides,
      kycStatus: kycStatus ?? this.kycStatus,
      vehicle: vehicle ?? this.vehicle,
      drivingLicense: drivingLicense ?? this.drivingLicense,
      stats: stats ?? this.stats,
      reviews: reviews ?? this.reviews,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      reportCount: reportCount ?? this.reportCount,
    );
  }
}