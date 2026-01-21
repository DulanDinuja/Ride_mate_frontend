import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/kyc_provider.dart';
import '../providers/auth_provider.dart';
import '../../../data/models/kyc_model.dart';
import 'kyc_verification_screen.dart';

class KycStatusScreen extends StatefulWidget {
  const KycStatusScreen({super.key});

  @override
  State<KycStatusScreen> createState() => _KycStatusScreenState();
}

class _KycStatusScreenState extends State<KycStatusScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final kycProvider = Provider.of<KycProvider>(context, listen: false);
      if (authProvider.userId != null) {
        kycProvider.loadKycStatus(authProvider.userId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KycProvider>(
      builder: (context, kycProvider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('KYC Status')),
          body: kycProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : kycProvider.kycData == null
                  ? _buildNoKycData()
                  : _buildKycStatus(kycProvider.kycData!),
        );
      },
    );
  }

  Widget _buildNoKycData() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified_user_outlined, size: 80, color: AppColors.textSecondary),
            const SizedBox(height: 24),
            const Text(
              'KYC Not Submitted',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Complete your KYC verification to access all features',
              style: TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const KycVerificationScreen()),
              ),
              child: const Text('Start KYC Verification'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKycStatus(KycModel kyc) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStatusCard(kyc),
          const SizedBox(height: 24),
          _buildDetailsCard(kyc),
          if (kyc.status == KycStatus.rejected) ...[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Provider.of<KycProvider>(context, listen: false).reset();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const KycVerificationScreen()),
                );
              },
              child: const Text('Resubmit KYC'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusCard(KycModel kyc) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (kyc.status) {
      case KycStatus.notSubmitted:
        statusColor = AppColors.textSecondary;
        statusIcon = Icons.info_outline;
        statusText = 'Not Submitted';
        break;
      case KycStatus.pending:
        statusColor = AppColors.warning;
        statusIcon = Icons.pending;
        statusText = 'Pending Review';
        break;
      case KycStatus.underReview:
        statusColor = AppColors.cyan;
        statusIcon = Icons.hourglass_empty;
        statusText = 'Under Review';
        break;
      case KycStatus.approved:
        statusColor = AppColors.success;
        statusIcon = Icons.verified;
        statusText = 'Approved';
        break;
      case KycStatus.rejected:
        statusColor = AppColors.error;
        statusIcon = Icons.cancel;
        statusText = 'Rejected';
        break;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(statusIcon, size: 48, color: statusColor),
            ),
            const SizedBox(height: 16),
            Text(
              statusText,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getStatusDescription(kyc.status),
              style: const TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(KycModel kyc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verification Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('NIC Number', kyc.nicNumber),
            _buildDetailRow('Submitted', _formatDate(kyc.submittedAt)),
            if (kyc.rejectionReason != null)
              _buildDetailRow('Rejection Reason', kyc.rejectionReason!),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  String _getStatusDescription(KycStatus status) {
    switch (status) {
      case KycStatus.notSubmitted:
        return 'KYC verification not started yet';
      case KycStatus.pending:
        return 'Your documents are in queue for review';
      case KycStatus.underReview:
        return 'Our team is currently reviewing your documents';
      case KycStatus.approved:
        return 'Your identity has been verified successfully';
      case KycStatus.rejected:
        return 'Your documents need to be resubmitted';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}