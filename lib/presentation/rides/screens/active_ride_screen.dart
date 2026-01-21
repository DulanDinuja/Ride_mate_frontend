import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ActiveRideScreen extends StatelessWidget {
  const ActiveRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Active Ride')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: AppColors.surface,
              child: const Center(child: Text('Map View')),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary,
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(child: Icon(Icons.person)),
                    const SizedBox(width: 12),
                    const Expanded(child: Text('Sanjaya Kulathunga')),
                    IconButton(icon: const Icon(Icons.phone), onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                  child: const Text('SOS'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
