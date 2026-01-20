import 'package:flutter/material.dart';

class RideDetailsScreen extends StatelessWidget {
  const RideDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ride Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
                  SizedBox(height: 12),
                  Text('Sanjaya Kulathunga', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text(' 4.8'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Route', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Text('Colombo Fort → Kandy City'),
                  Text('Today, 8:00 AM'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Book Ride'),
          ),
        ],
      ),
    );
  }
}
