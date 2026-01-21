import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/liquid_background.dart';
import '../providers/auth_provider.dart';
import 'kyc_verification_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isDriver = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidBackground(
        bubbleCount: 8,
        child: Stack(
          children: [
            const FloatingParticles(particleCount: 20),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.cyan.withOpacity(0.2),
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back, color: AppColors.cyan),
                          ),
                        ),
                        Expanded(
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [AppColors.cyan, AppColors.accentLight],
                            ).createShader(bounds),
                            child: const Text(
                              'Create Account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    const SizedBox(height: 32),
                    GlassContainer(
                      padding: const EdgeInsets.all(24),
                      blur: 15,
                      opacity: 0.15,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GlassTextField(
                              controller: _nameController,
                              hintText: 'Full Name',
                              labelText: 'Full Name',
                              prefixIcon: Icons.person_outline,
                              validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                            ),
                            const SizedBox(height: 16),
                            GlassTextField(
                              controller: _phoneController,
                              hintText: 'Phone Number',
                              labelText: 'Phone Number',
                              prefixIcon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                            ),
                            const SizedBox(height: 16),
                            GlassTextField(
                              controller: _emailController,
                              hintText: 'Email',
                              labelText: 'Email',
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                            ),
                            const SizedBox(height: 16),
                            GlassTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              labelText: 'Password',
                              prefixIcon: Icons.lock_outline,
                              suffixIcon: _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              onSuffixIconTap: () => setState(() => _obscurePassword = !_obscurePassword),
                              obscureText: _obscurePassword,
                              validator: (v) => (v?.length ?? 0) < 6 ? 'Min 6 characters' : null,
                            ),
                            const SizedBox(height: 24),
                            GlassContainer(
                              padding: const EdgeInsets.all(16),
                              blur: 10,
                              opacity: 0.1,
                              borderRadius: BorderRadius.circular(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'I want to:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  CheckboxListTile(
                                    title: const Text(
                                      'Start rides (Driver)',
                                      style: TextStyle(color: AppColors.textPrimary),
                                    ),
                                    subtitle: const Text(
                                      'Share costs by offering rides',
                                      style: TextStyle(color: AppColors.textSecondary),
                                    ),
                                    value: _isDriver,
                                    onChanged: (v) => setState(() => _isDriver = v ?? false),
                                    contentPadding: EdgeInsets.zero,
                                    activeColor: AppColors.accent,
                                    checkColor: AppColors.textPrimary,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Consumer<AuthProvider>(
                              builder: (context, auth, _) {
                                return GlassButton(
                                  text: 'Create Account',
                                  icon: Icons.person_add,
                                  onPressed: _handleRegister,
                                  isLoading: auth.isLoading,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      final success = await context.read<AuthProvider>().register(
            phoneNumber: _phoneController.text,
            email: _emailController.text,
            password: _passwordController.text,
            fullName: _nameController.text,
            wantsToStartRides: _isDriver,
          );

      if (success && mounted) {
        if (_isDriver) {
          // Navigate to KYC for users who want to start rides
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const KycVerificationScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: animation.drive(Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)),
                  child: child,
                );
              },
            ),
          );
        } else {
          // Navigate directly to dashboard for passenger-only users
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
