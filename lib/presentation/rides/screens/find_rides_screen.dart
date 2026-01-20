import 'package:flutter/material.dart';

class FindRidesScreen extends StatefulWidget {
  const FindRidesScreen({super.key});

  @override
  State<FindRidesScreen> createState() => _FindRidesScreenState();
}

class _FindRidesScreenState extends State<FindRidesScreen> {
  String? _genderFilter;
  RangeValues _priceRange = const RangeValues(0, 5000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Rides'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: _showFilters),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'From',
                    prefixIcon: Icon(Icons.my_location),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                ),
                const SizedBox(height: 12),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'To',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) => _buildRideCard(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(child: Icon(Icons.person)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Sanjaya Kulathunga', style: TextStyle(fontWeight: FontWeight.bold)),
                        const Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.amber),
                            Text(' 4.8'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Text('LKR 500', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const Divider(height: 24),
              const Row(
                children: [
                  Icon(Icons.circle, size: 12, color: Colors.green),
                  SizedBox(width: 8),
                  Expanded(child: Text('Colombo Fort')),
                  Text('Today, 8:00 AM'),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.circle, size: 12, color: Colors.red),
                  SizedBox(width: 8),
                  Expanded(child: Text('Kandy City')),
                  Text('3 seats left'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Filters', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _genderFilter,
              isExpanded: true,
              hint: const Text('Gender Preference'),
              items: ['Male', 'Female', 'Any'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _genderFilter = v),
            ),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 5000,
              onChanged: (v) => setState(() => _priceRange = v),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}
