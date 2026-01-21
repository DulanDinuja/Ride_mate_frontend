import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/providers/kyc_provider.dart';
import '../../auth/screens/login_screen.dart';
import '../../auth/screens/kyc_status_screen.dart';
import '../../../data/models/kyc_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return Consumer2<AuthProvider, KycProvider>(
      builder: (context, authProvider, kycProvider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Profile')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Center(
                child: Column(
                  children: [
                    CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
                    SizedBox(height: 16),
                    Text('Sanjaya Kulathunga', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, size: 20, color: AppColors.warning),
                        Text(' 4.8'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _buildKycMenuItem(kycProvider),
              _buildMenuItem(Icons.directions_car, 'My Vehicles', ''),
              _buildMenuItem(Icons.payment, 'Payment Methods', ''),
              _buildMenuItem(Icons.settings, 'Settings', ''),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  authProvider.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                child: const Text('Logout'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKycMenuItem(KycProvider kycProvider) {
    String subtitle = 'Loading...';
    Color statusColor = AppColors.textSecondary;
    IconData statusIcon = Icons.hourglass_empty;

    if (kycProvider.isLoading) {
      // Keep defaults
    } else if (kycProvider.kycData == null) {
      subtitle = 'Not submitted';
      statusColor = AppColors.warning;
      statusIcon = Icons.warning;
    } else {
      switch (kycProvider.kycData!.status) {
        case KycStatus.notSubmitted:
          subtitle = 'Not submitted';
          statusColor = AppColors.textSecondary;
          statusIcon = Icons.info_outline;
          break;
        case KycStatus.pending:
          subtitle = 'Pending review';
          statusColor = AppColors.warning;
          statusIcon = Icons.pending;
          break;
        case KycStatus.underReview:
          subtitle = 'Under review';
          statusColor = AppColors.cyan;
          statusIcon = Icons.hourglass_empty;
          break;
        case KycStatus.approved:
          subtitle = 'Verified';
          statusColor = AppColors.success;
          statusIcon = Icons.verified;
          break;
        case KycStatus.rejected:
          subtitle = 'Rejected';
          statusColor = AppColors.error;
          statusIcon = Icons.cancel;
          break;
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(statusIcon, color: statusColor),
        title: const Text('KYC Status'),
        subtitle: Text(subtitle, style: TextStyle(color: statusColor)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const KycStatusScreen()),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
