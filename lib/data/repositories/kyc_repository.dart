import 'package:dio/dio.dart';
import 'dart:io';
import '../models/kyc_model.dart';
import '../../core/constants/app_constants.dart';

class KycRepository {
  final Dio _dio = Dio();

  Future<String> uploadImage(File imageFile, String type) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path),
        'type': type,
      });

      final response = await _dio.post(
        '${AppConstants.baseUrl}/kyc/upload',
        data: formData,
      );

      return response.data['url'];
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<KycModel> submitKyc({
    required String userId,
    required String nicNumber,
    required String nicFrontUrl,
    required String nicBackUrl,
    required String selfieUrl,
  }) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}/kyc/submit',
        data: {
          'userId': userId,
          'nicNumber': nicNumber,
          'nicFrontUrl': nicFrontUrl,
          'nicBackUrl': nicBackUrl,
          'selfieUrl': selfieUrl,
        },
      );

      return KycModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to submit KYC: $e');
    }
  }

  Future<KycModel?> getKycStatus(String userId) async {
    try {
      final response = await _dio.get('${AppConstants.baseUrl}/kyc/status/$userId');
      return response.data != null ? KycModel.fromJson(response.data) : null;
    } catch (e) {
      throw Exception('Failed to get KYC status: $e');
    }
  }
}