import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/ride_provider.dart';

class FindRideScreen extends StatefulWidget {
  const FindRideScreen({super.key});

  @override
  State<FindRideScreen> createState() => _FindRideScreenState();
}

class _FindRideScreenState extends State<FindRideScreen> {
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  DateTime? _selectedDate;
  List<Map<String, dynamic>> _filteredRides = [];
  
  final List<Map<String, dynamic>> _allRides = [
    {
      'from': 'Colombo',
      'to': 'Kandy',
      'date': '2024-01-15',
      'time': '08:00',
      'price': 500,
      'seats': 3,
      'driver': 'John Doe',
      'rating': 4.5,
    },
    {
      'from': 'Galle',
      'to': 'Colombo',
      'date': '2024-01-15',
      'time': '09:30',
      'price': 400,
      'seats': 2,
      'driver': 'Jane Smith',
      'rating': 4.8,
    },
    {
      'from': 'Kandy',
      'to': 'Colombo',
      'date': '2024-01-16',
      'time': '07:00',
      'price': 450,
      'seats': 4,
      'driver': 'Mike Wilson',
      'rating': 4.2,
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredRides = _allRides;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Find Ride')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _fromController,
                        decoration: const InputDecoration(
                          hintText: 'From',
                          prefixIcon: Icon(Icons.my_location),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _toController,
                        decoration: const InputDecoration(
                          hintText: 'To',
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: _selectDate,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today),
                              const SizedBox(width: 8),
                              Text(_selectedDate?.toString().split(' ')[0] ?? 'Select date'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _searchRides,
                      child: const Text('Search'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredRides.length,
              itemBuilder: (context, index) => _buildRideCard(_filteredRides[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideCard(Map<String, dynamic> ride) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${ride['from']} → ${ride['to']}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text('${ride['date']} at ${ride['time']}'),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'LKR ${ride['price']}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    Text('${ride['seats']} seats'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  child: Text(ride['driver'][0]),
                ),
                const SizedBox(width: 8),
                Text(ride['driver']),
                const SizedBox(width: 8),
                Icon(Icons.star, size: 16, color: Colors.amber),
                Text('${ride['rating']}'),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _bookRide(ride),
                  child: const Text('Book'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  void _searchRides() {
    final from = _fromController.text.toLowerCase();
    final to = _toController.text.toLowerCase();
    
    setState(() {
      _filteredRides = _allRides.where((ride) {
        final matchesFrom = from.isEmpty || ride['from'].toString().toLowerCase().contains(from);
        final matchesTo = to.isEmpty || ride['to'].toString().toLowerCase().contains(to);
        return matchesFrom && matchesTo;
      }).toList();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Found ${_filteredRides.length} rides')),
    );
  }

  void _bookRide(Map<String, dynamic> ride) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Book Ride'),
        content: Text('Book ride from ${ride['from']} to ${ride['to']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ride booked successfully!')),
              );
            },
            child: const Text('Book'),
          ),
        ],
      ),
    );
  }
}