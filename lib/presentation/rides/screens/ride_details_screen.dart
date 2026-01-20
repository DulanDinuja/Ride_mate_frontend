import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/ride_provider.dart';

class RideDetailsScreen extends StatelessWidget {
  final String rideId;
  
  const RideDetailsScreen({super.key, required this.rideId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ride Details')),
      body: const Center(
        child: Text('Ride details coming soon'),
      ),
    );
  }
}