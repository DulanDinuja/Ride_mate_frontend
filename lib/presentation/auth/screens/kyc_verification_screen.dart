import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/liquid_background.dart';
import '../providers/kyc_provider.dart';
import '../providers/auth_provider.dart';
import '../../../core/utils/kyc_validator.dart';
import '../../dashboard/screens/main_dashboard.dart';

class KycVerificationScreen extends StatefulWidget {
  const KycVerificationScreen({super.key});

  @override
  State<KycVerificationScreen> createState() => _KycVerificationScreenState();
}

class _KycVerificationScreenState extends State<KycVerificationScreen> {
  final ImagePicker _picker = ImagePicker();
  final _nicController = TextEditingController();

  @override
  void dispose() {
    _nicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<KycProvider, AuthProvider>(
      builder: (context, kycProvider, authProvider, child) {
        // Clear any previous connection errors on screen load
        if (kycProvider.error != null && kycProvider.error!.contains('DioException')) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            kycProvider.clearError();
          });
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: GlassAppBar(
            title: 'KYC Verification',
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cyan.withOpacity(0.2),
                ),
                child: const Icon(Icons.arrow_back, color: AppColors.cyan),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: LiquidBackground(
            bubbleCount: 6,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    GlassContainer(
                      padding: const EdgeInsets.all(20),
                      blur: 15,
                      opacity: 0.15,
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [AppColors.cyan, AppColors.accentLight],
                            ).createShader(bounds),
                            child: const Text(
                              'Complete KYC to Start Rides',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Upload your documents to verify your identity and start offering rides',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    GlassTextField(
                      controller: _nicController,
                      hintText: 'Enter your NIC number',
                      labelText: 'NIC Number',
                      prefixIcon: Icons.credit_card,
                      validator: KycValidator.validateNicNumber,
                    ),

                    const SizedBox(height: 24),

                    _buildImageCard('NIC Front', kycProvider.nicFront, () => _pickImage(0, kycProvider)),
                    const SizedBox(height: 16),
                    _buildImageCard('NIC Back', kycProvider.nicBack, () => _pickImage(1, kycProvider)),
                    const SizedBox(height: 16),
                    _buildImageCard('Live Selfie', kycProvider.selfie, () => _pickImage(2, kycProvider)),

                    if (kycProvider.error != null && !kycProvider.error!.contains('DioException')) ...[
                      const SizedBox(height: 16),
                      GlassContainer(
                        padding: const EdgeInsets.all(16),
                        color: AppColors.error,
                        opacity: 0.2,
                        border: Border.all(
                          color: AppColors.error.withOpacity(0.6),
                          width: 1.5,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: AppColors.error),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                kycProvider.error!,
                                style: const TextStyle(color: AppColors.error),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 32),
                    GlassButton(
                      text: 'Submit for Verification',
                      icon: Icons.verified_user,
                      onPressed: kycProvider.canSubmit ? () => _submitKyc(kycProvider, authProvider) : () {},
                      isLoading: kycProvider.isLoading,
                      gradientColors: kycProvider.canSubmit
                          ? [AppColors.accent.withOpacity(0.8), AppColors.accentLight.withOpacity(0.9)]
                          : [AppColors.textSecondary.withOpacity(0.3), AppColors.textSecondary.withOpacity(0.2)],
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: kycProvider.isLoading ? null : () => _skipKyc(),
                      child: const Text(
                        'Skip for now',
                        style: TextStyle(color: AppColors.cyan),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageCard(String label, File? image, VoidCallback onTap) {
    return LiquidGlassCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      gradientColors: image != null
          ? [AppColors.success.withOpacity(0.6), AppColors.success.withOpacity(0.4)]
          : [AppColors.cyan.withOpacity(0.6), AppColors.cyanBright.withOpacity(0.4)],
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(16),
        child: image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.cyan, AppColors.cyanBright],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.cyan.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add_a_photo,
                      size: 32,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap to ${label.contains('Selfie') ? 'capture' : 'upload'}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  // Dark overlay for better icon visibility
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Success indicator
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.success.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.textPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                  // Label overlay
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: GlassContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      blur: 10,
                      opacity: 0.2,
                      borderRadius: BorderRadius.circular(8),
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _pickImage(int type, KycProvider provider) async {
    try {
      final source = type == 2 ? ImageSource.camera : ImageSource.gallery;
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        final file = File(image.path);
        switch (type) {
          case 0:
            provider.setNicFront(file);
            break;
          case 1:
            provider.setNicBack(file);
            break;
          case 2:
            provider.setSelfie(file);
            break;
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _submitKyc(KycProvider kycProvider, AuthProvider authProvider) async {
    // Update NIC number from text field
    final nicNumber = _nicController.text.trim();
    if (nicNumber.isNotEmpty) {
      kycProvider.setNicNumber(nicNumber);
    }

    // Validate NIC number
    final nicError = KycValidator.validateNicNumber(nicNumber);
    if (nicError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(nicError),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (authProvider.userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not authenticated. Please log in again.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final success = await kycProvider.submitKyc(authProvider.userId!);
    
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: AppColors.textPrimary),
              SizedBox(width: 12),
              Expanded(
                child: Text('KYC submitted successfully! We will review and notify you.'),
              ),
            ],
          ),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 3),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainDashboard()),
      );
    } else if (mounted && kycProvider.error != null) {
      // Error is already shown in the UI, but show a snackbar too
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(kycProvider.error!),
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  void _skipKyc() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassContainer(
          padding: const EdgeInsets.all(24),
          blur: 15,
          opacity: 0.15,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.warning, Color(0xFFFFD700)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.warning.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  size: 48,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Skip KYC Verification?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'You can join rides as a passenger, but you won\'t be able to start rides until you complete KYC verification.\n\nYou can complete this later from your profile.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GlassButton(
                      text: 'Cancel',
                      onPressed: () => Navigator.pop(context),
                      gradientColors: [
                        AppColors.textSecondary.withOpacity(0.5),
                        AppColors.textSecondary.withOpacity(0.3),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GlassButton(
                      text: 'Skip',
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const MainDashboard()),
                        );
                      },
                      gradientColors: [
                        AppColors.warning.withOpacity(0.8),
                        AppColors.warning.withOpacity(0.6),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
