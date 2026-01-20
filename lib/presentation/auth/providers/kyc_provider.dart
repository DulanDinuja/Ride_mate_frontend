import 'package:flutter/material.dart';
import 'dart:io';
import '../../../data/models/kyc_model.dart';
import '../../../data/repositories/kyc_repository.dart';

class KycProvider extends ChangeNotifier {
  final KycRepository _repository = KycRepository();
  
  bool _isLoading = false;
  String? _error;
  KycModel? _kycData;
  
  File? _nicFront;
  File? _nicBack;
  File? _selfie;
  String _nicNumber = '';

  bool get isLoading => _isLoading;
  String? get error => _error;
  KycModel? get kycData => _kycData;
  File? get nicFront => _nicFront;
  File? get nicBack => _nicBack;
  File? get selfie => _selfie;
  String get nicNumber => _nicNumber;

  bool get canSubmit => 
    _nicFront != null && 
    _nicBack != null && 
    _selfie != null && 
    _nicNumber.isNotEmpty;

  void setNicFront(File file) {
    _nicFront = file;
    notifyListeners();
  }

  void setNicBack(File file) {
    _nicBack = file;
    notifyListeners();
  }

  void setSelfie(File file) {
    _selfie = file;
    notifyListeners();
  }

  void setNicNumber(String number) {
    _nicNumber = number;
    notifyListeners();
  }

  Future<void> loadKycStatus(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _kycData = await _repository.getKycStatus(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> submitKyc(String userId) async {
    if (!canSubmit) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Upload images
      final nicFrontUrl = await _repository.uploadImage(_nicFront!, 'nic_front');
      final nicBackUrl = await _repository.uploadImage(_nicBack!, 'nic_back');
      final selfieUrl = await _repository.uploadImage(_selfie!, 'selfie');

      // Submit KYC
      _kycData = await _repository.submitKyc(
        userId: userId,
        nicNumber: _nicNumber,
        nicFrontUrl: nicFrontUrl,
        nicBackUrl: nicBackUrl,
        selfieUrl: selfieUrl,
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void reset() {
    _nicFront = null;
    _nicBack = null;
    _selfie = null;
    _nicNumber = '';
    _error = null;
    notifyListeners();
  }
}