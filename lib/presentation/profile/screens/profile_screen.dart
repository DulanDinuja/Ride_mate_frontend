import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/liquid_background.dart';
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
          extendBodyBehindAppBar: true,
          appBar: GlassAppBar(title: 'Profile'),
          body: LiquidBackground(
            bubbleCount: 6,
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const SizedBox(height: 16),
                  GlassContainer(
                    padding: const EdgeInsets.all(24),
                    blur: 15,
                    opacity: 0.15,
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [AppColors.cyan, AppColors.cyanBright],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.cyan.withOpacity(0.5),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [AppColors.cyan, AppColors.accentLight],
                          ).createShader(bounds),
                          child: const Text(
                            'Sanjaya Kulathunga',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star, size: 20, color: AppColors.warning),
                            const Text(
                              ' 4.8',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildKycMenuItem(kycProvider),
                  const SizedBox(height: 8),
                  _buildMenuItem(Icons.directions_car, 'My Vehicles', '', [
                    AppColors.accent.withOpacity(0.6),
                    AppColors.accentLight.withOpacity(0.4),
                  ]),
                  const SizedBox(height: 8),
                  _buildMenuItem(Icons.payment, 'Payment Methods', '', [
                    AppColors.cyan.withOpacity(0.6),
                    AppColors.cyanBright.withOpacity(0.4),
                  ]),
                  const SizedBox(height: 8),
                  _buildMenuItem(Icons.settings, 'Settings', '', [
                    AppColors.blueViolet.withOpacity(0.6),
                    AppColors.purple.withOpacity(0.4),
                  ]),
                  const SizedBox(height: 24),
                  GlassButton(
                    text: 'Logout',
                    icon: Icons.logout,
                    gradientColors: [
                      AppColors.error.withOpacity(0.8),
                      AppColors.error.withOpacity(0.6),
                    ],
                    onPressed: () {
                      authProvider.logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
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

    return LiquidGlassCard(
      padding: const EdgeInsets.all(16),
      gradientColors: [
        statusColor.withOpacity(0.6),
        statusColor.withOpacity(0.4),
      ],
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const KycStatusScreen()),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusColor.withOpacity(0.2),
              border: Border.all(
                color: statusColor.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Icon(statusIcon, color: statusColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'KYC Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.cyan),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle, List<Color> colors) {
    return LiquidGlassCard(
      padding: const EdgeInsets.all(16),
      gradientColors: colors,
      onTap: () {},
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: colors),
              boxShadow: [
                BoxShadow(
                  color: colors[0].withOpacity(0.3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.textPrimary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.cyan),
        ],
      ),
    );
  }
}
