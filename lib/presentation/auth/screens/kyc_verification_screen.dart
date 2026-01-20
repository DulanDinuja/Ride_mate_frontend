import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
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
        return Scaffold(
          appBar: AppBar(title: const Text('KYC Verification')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Verify your identity', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Upload NIC and take selfie for verification', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 32),
                
                TextFormField(
                  controller: _nicController,
                  decoration: const InputDecoration(
                    labelText: 'NIC Number',
                    hintText: 'Enter your NIC number (e.g., 123456789V or 123456789012)',
                    border: OutlineInputBorder(),
                  ),
                  validator: KycValidator.validateNicNumber,
                  onChanged: (value) {
                    final formatted = KycValidator.formatNicNumber(value);
                    kycProvider.setNicNumber(formatted);
                  },
                ),
                const SizedBox(height: 24),
                
                _buildImageCard('NIC Front', kycProvider.nicFront, () => _pickImage(0, kycProvider)),
                const SizedBox(height: 16),
                _buildImageCard('NIC Back', kycProvider.nicBack, () => _pickImage(1, kycProvider)),
                const SizedBox(height: 16),
                _buildImageCard('Live Selfie', kycProvider.selfie, () => _pickImage(2, kycProvider)),
                
                if (kycProvider.error != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Text(
                      kycProvider.error!,
                      style: TextStyle(color: Colors.red.shade700),
                    ),
                  ),
                ],
                
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: kycProvider.isLoading ? null : 
                    (kycProvider.canSubmit ? () => _submitKyc(kycProvider, authProvider) : null),
                  child: kycProvider.isLoading 
                    ? const CircularProgressIndicator()
                    : const Text('Submit for Verification'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: kycProvider.isLoading ? null : () => _skipKyc(),
                  child: const Text('Skip for now'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageCard(String label, File? image, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(16),
          child: image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo, size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 8),
                    Text(label, style: TextStyle(color: Colors.grey.shade600)),
                    const SizedBox(height: 4),
                    Text('Tap to ${label.contains('Selfie') ? 'capture' : 'upload'}', 
                         style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                  ],
                )
              : Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(image, fit: BoxFit.cover, width: double.infinity),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _pickImage(int type, KycProvider provider) async {
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
  }

  Future<void> _submitKyc(KycProvider kycProvider, AuthProvider authProvider) async {
    if (authProvider.userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
      return;
    }

    final success = await kycProvider.submitKyc(authProvider.userId!);
    
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('KYC submitted successfully! We will review and notify you.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (_) => const MainDashboard()),
      );
    }
  }

  void _skipKyc() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Skip KYC Verification?'),
        content: const Text('You can complete KYC verification later from your profile. Some features may be limited without verification.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainDashboard()),
              );
            },
            child: const Text('Skip'),
          ),
        ],
      ),
    );
  }
}
