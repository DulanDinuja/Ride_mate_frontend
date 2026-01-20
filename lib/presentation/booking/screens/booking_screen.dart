import 'package:flutter/material.dart';
import '../../rides/screens/cost_sharing_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _seats = 1;
  String _payment = 'Cash';
  double _totalCost = 1000.0; // Example total cost

  @override
  Widget build(BuildContext context) {
    final costPerSeat = _totalCost / (_seats + 1); // +1 for driver
    
    return Scaffold(
      appBar: AppBar(title: const Text('Book Ride')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Seats', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: _seats > 1 ? () => setState(() => _seats--) : null,
                      ),
                      Text('$_seats', style: const TextStyle(fontSize: 24)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => setState(() => _seats++),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Cost Breakdown', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Cost:'),
                      Text('LKR ${_totalCost.toStringAsFixed(2)}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Cost per person:'),
                      Text('LKR ${costPerSeat.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CostSharingScreen(
                          totalCost: _totalCost,
                          participants: _seats,
                        ),
                      ),
                    ),
                    child: const Text('View Cost Sharing'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                RadioListTile(
                  title: const Text('Cash'),
                  value: 'Cash',
                  groupValue: _payment,
                  onChanged: (v) => setState(() => _payment = v!),
                ),
                RadioListTile(
                  title: const Text('Card'),
                  value: 'Card',
                  groupValue: _payment,
                  onChanged: (v) => setState(() => _payment = v!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Booking confirmed! You pay LKR ${costPerSeat.toStringAsFixed(2)}')),
              );
            },
            child: const Text('Confirm Booking'),
          ),
        ],
      ),
    );
  }
}
