import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            Icon(Icons.verified_user_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 24),
            const Text(
              'KYC Not Submitted',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Complete your KYC verification to access all features',
              style: TextStyle(color: Colors.grey.shade600),
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
      case KycStatus.pending:
        statusColor = Colors.orange;
        statusIcon = Icons.pending;
        statusText = 'Pending Review';
        break;
      case KycStatus.underReview:
        statusColor = Colors.blue;
        statusIcon = Icons.hourglass_empty;
        statusText = 'Under Review';
        break;
      case KycStatus.approved:
        statusColor = Colors.green;
        statusIcon = Icons.verified;
        statusText = 'Approved';
        break;
      case KycStatus.rejected:
        statusColor = Colors.red;
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
              style: TextStyle(color: Colors.grey.shade600),
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
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
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