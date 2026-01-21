import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'home_screen.dart';
import '../../rides/screens/find_rides_screen.dart';
import '../../rides/screens/my_rides_screen.dart';
import '../../rides/screens/create_ride_screen.dart';
import '../../profile/screens/profile_screen.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _fabController;

  final List<Widget> _screens = [
    const HomeScreen(),
    const FindRidesScreen(),
    const MyRidesScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.cyan.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withOpacity(0.8),
                    AppColors.primaryDark.withOpacity(0.9),
                  ],
                ),
                border: Border(
                  top: BorderSide(
                    color: AppColors.cyan.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) => setState(() => _currentIndex = index),
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColors.cyan,
                unselectedItemColor: AppColors.textSecondary,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                items: [
                  _buildNavItem(Icons.home, 'Home', 0),
                  _buildNavItem(Icons.search, 'Search', 1),
                  _buildNavItem(Icons.directions_car, 'My Rides', 2),
                  _buildNavItem(Icons.person, 'Profile', 3),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTapDown: (_) => _fabController.forward(),
        onTapUp: (_) {
          _fabController.reverse();
          Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateRideScreen()));
        },
        onTapCancel: () => _fabController.reverse(),
        child: AnimatedBuilder(
          animation: _fabController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 - (_fabController.value * 0.1),
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.accent, AppColors.accentLight],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.4 + (_fabController.value * 0.2)),
                      blurRadius: 20 + (_fabController.value * 10),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.textPrimary,
                  size: 32,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index
              ? AppColors.cyan.withOpacity(0.2)
              : Colors.transparent,
        ),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}
