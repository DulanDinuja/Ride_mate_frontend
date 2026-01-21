import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/liquid_background.dart';
import '../../rides/screens/offer_ride_screen.dart';
import '../../rides/screens/find_ride_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: 'RideMate',
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cyan.withOpacity(0.2),
              ),
              child: const Icon(Icons.notifications),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LiquidBackground(
        bubbleCount: 8,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                GlassContainer(
                  padding: const EdgeInsets.all(20),
                  blur: 15,
                  opacity: 0.15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Where are you going?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GlassTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter destination',
                        prefixIcon: Icons.search,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.cyan, AppColors.accentLight],
                  ).createShader(bounds),
                  child: const Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildActionCard(
                        context,
                        Icons.directions_car,
                        'Offer Ride',
                        [AppColors.accent.withOpacity(0.8), AppColors.accentLight.withOpacity(0.6)],
                        const OfferRideScreen(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildActionCard(
                        context,
                        Icons.search,
                        'Find Ride',
                        [AppColors.cyan.withOpacity(0.8), AppColors.cyanBright.withOpacity(0.6)],
                        const FindRideScreen(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.cyan, AppColors.accentLight],
                  ).createShader(bounds),
                  child: const Text(
                    'Recent Rides',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildRecentRideCard(context),
                const SizedBox(height: 16),
                _buildRecentRideCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, IconData icon, String label, List<Color> colors, Widget screen) {
    return LiquidGlassCard(
      padding: const EdgeInsets.all(24),
      gradientColors: colors,
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: colors),
              boxShadow: [
                BoxShadow(
                  color: colors[0].withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, size: 32, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentRideCard(BuildContext context) {
    return LiquidGlassCard(
      padding: const EdgeInsets.all(16),
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.cyan, AppColors.cyanBright],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cyan.withOpacity(0.3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(Icons.directions_car, color: AppColors.textPrimary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Colombo to Galle',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Today, 3:00 PM',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: AppColors.cyan, size: 16),
        ],
      ),
    );
  }
}
