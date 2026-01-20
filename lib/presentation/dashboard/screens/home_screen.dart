import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RideMate'),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Where are you going?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter destination',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildActionCard(Icons.directions_car, 'Offer Ride', Colors.green)),
                const SizedBox(width: 16),
                Expanded(child: _buildActionCard(Icons.search, 'Find Ride', Colors.blue)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(IconData icon, String label, Color color) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 8),
              Text(label, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
