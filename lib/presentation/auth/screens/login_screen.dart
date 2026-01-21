import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/liquid_background.dart';
import '../providers/auth_provider.dart';
import '../../dashboard/screens/main_dashboard.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidBackground(
        child: Stack(
          children: [
            const FloatingParticles(particleCount: 25),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    Hero(
                      tag: 'app_logo',
                      child: GlassShimmer(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.cyan, AppColors.cyanBright],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.cyan.withOpacity(0.5),
                                blurRadius: 40,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.directions_car,
                            size: 60,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [AppColors.cyan, AppColors.accentLight],
                      ).createShader(bounds),
                      child: const Text(
                        'Welcome Back!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign in to continue your journey',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 48),
                    GlassContainer(
                      padding: const EdgeInsets.all(24),
                      blur: 15,
                      opacity: 0.15,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            GlassTextField(
                              controller: _emailController,
                              hintText: 'Email or Phone',
                              labelText: 'Email or Phone',
                              prefixIcon: Icons.person_outline,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                            ),
                            const SizedBox(height: 20),
                            GlassTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              labelText: 'Password',
                              prefixIcon: Icons.lock_outline,
                              suffixIcon: _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              onSuffixIconTap: () => setState(() => _obscurePassword = !_obscurePassword),
                              obscureText: _obscurePassword,
                              validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: AppColors.cyan),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Consumer<AuthProvider>(
                              builder: (context, auth, _) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    GlassButton(
                                      text: 'Sign In',
                                      onPressed: _handleLogin,
                                      icon: Icons.login,
                                      isLoading: auth.isLoading,
                                    ),
                                    if (auth.error != null) ...[
                                      const SizedBox(height: 16),
                                      GlassContainer(
                                        padding: const EdgeInsets.all(12),
                                        color: AppColors.error,
                                        opacity: 0.2,
                                        border: Border.all(
                                          color: AppColors.error.withOpacity(0.6),
                                          width: 1.5,
                                        ),
                                        child: Text(
                                          auth.error!,
                                          style: const TextStyle(color: AppColors.error),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const RegisterScreen(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return SlideTransition(
                                    position: animation.drive(Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: AppColors.cyan,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final success = await context.read<AuthProvider>().login(
            email: _emailController.text,
            password: _passwordController.text,
          );

      if (success && mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const MainDashboard(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    }
  }
}