import 'package:flutter/material.dart';

class CreateRideScreen extends StatefulWidget {
  const CreateRideScreen({super.key});

  @override
  State<CreateRideScreen> createState() => _CreateRideScreenState();
}

class _CreateRideScreenState extends State<CreateRideScreen> {
  final _originController = TextEditingController();
  final _destController = TextEditingController();
  int _seats = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Ride')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _originController,
            decoration: const InputDecoration(
              labelText: 'Pickup Location',
              prefixIcon: Icon(Icons.my_location),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _destController,
            decoration: const InputDecoration(
              labelText: 'Destination',
              prefixIcon: Icon(Icons.location_on),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Seats'),
          Slider(
            value: _seats.toDouble(),
            min: 1,
            max: 4,
            divisions: 3,
            label: _seats.toString(),
            onChanged: (v) => setState(() => _seats = v.toInt()),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Create Ride'),
          ),
        ],
      ),
    );
  }
}
