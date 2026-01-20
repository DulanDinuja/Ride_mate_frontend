import 'package:flutter/material.dart';
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

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const FindRidesScreen(),
    const MyRidesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4CAF50),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'My Rides'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateRideScreen())),
        backgroundColor: const Color(0xFF4CAF50),
        child: const Icon(Icons.add),
      ),
    );
  }
}
