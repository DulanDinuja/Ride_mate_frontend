import 'package:flutter/material.dart';

class MyRidesScreen extends StatelessWidget {
  const MyRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Rides'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Upcoming'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildRidesList(),
            _buildRidesList(),
            _buildRidesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRidesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.directions_car)),
          title: const Text('Colombo to Kandy'),
          subtitle: const Text('Today, 8:00 AM'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
      ),
    );
  }
}
