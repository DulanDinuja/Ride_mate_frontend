import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _seats = 1;
  String _payment = 'Cash';

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
            child: const Text('Confirm Booking'),
          ),
        ],
      ),
    );
  }
}
