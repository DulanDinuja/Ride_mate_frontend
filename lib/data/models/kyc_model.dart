class KycModel {
  final String id;
  final String userId;
  final String nicNumber;
  final String nicFrontUrl;
  final String nicBackUrl;
  final String selfieUrl;
  final KycStatus status;
  final DateTime submittedAt;
  final String? rejectionReason;

  KycModel({
    required this.id,
    required this.userId,
    required this.nicNumber,
    required this.nicFrontUrl,
    required this.nicBackUrl,
    required this.selfieUrl,
    required this.status,
    required this.submittedAt,
    this.rejectionReason,
  });

  factory KycModel.fromJson(Map<String, dynamic> json) {
    return KycModel(
      id: json['id'],
      userId: json['userId'],
      nicNumber: json['nicNumber'],
      nicFrontUrl: json['nicFrontUrl'],
      nicBackUrl: json['nicBackUrl'],
      selfieUrl: json['selfieUrl'],
      status: KycStatus.values.firstWhere((e) => e.name == json['status']),
      submittedAt: DateTime.parse(json['submittedAt']),
      rejectionReason: json['rejectionReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'nicNumber': nicNumber,
      'nicFrontUrl': nicFrontUrl,
      'nicBackUrl': nicBackUrl,
      'selfieUrl': selfieUrl,
      'status': status.name,
      'submittedAt': submittedAt.toIso8601String(),
      'rejectionReason': rejectionReason,
    };
  }
}

enum KycStatus {
  pending,
  approved,
  rejected,
  underReview
}