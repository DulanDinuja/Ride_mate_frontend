import 'package:flutter/material.dart';

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
              color: Colors.grey[300],
              child: const Center(child: Text('Map View')),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
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
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
