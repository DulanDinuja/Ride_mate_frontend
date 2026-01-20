import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/ride_provider.dart';

class RideDiscoveryScreen extends StatelessWidget {
  const RideDiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discover Rides')),
      body: Consumer<RideProvider>(
        builder: (context, rideProvider, child) {
          final rides = rideProvider.availableRides;
          
          if (rides.isEmpty) {
            return const Center(
              child: Text('No rides available'),
            );
          }
          
          return ListView.builder(
            itemCount: rides.length,
            itemBuilder: (context, index) {
              final ride = rides[index];
              return ListTile(
                title: Text('${ride.origin.address} → ${ride.destination.address}'),
                subtitle: Text('LKR ${ride.costPerSeat.toStringAsFixed(2)}'),
                trailing: Text('${ride.availableSeats} seats'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final rideProvider = context.read<RideProvider>();
          rideProvider.searchRides('', '');
          rideProvider.loadNearbyRides(6.9271, 79.8612, 50.0);
          rideProvider.sortRidesByPrice(ascending: true);
          rideProvider.sortRidesByTime(ascending: true);
          rideProvider.sortRidesByRating(ascending: false);
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}