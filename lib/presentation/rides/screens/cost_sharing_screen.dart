import 'package:flutter/material.dart';

class CostSharingScreen extends StatefulWidget {
  final double totalCost;
  final int participants;

  const CostSharingScreen({
    super.key,
    required this.totalCost,
    required this.participants,
  });

  @override
  State<CostSharingScreen> createState() => _CostSharingScreenState();
}

class _CostSharingScreenState extends State<CostSharingScreen> {
  late double costPerPerson;
  late double driverShare;
  late double passengerShare;

  @override
  void initState() {
    super.initState();
    _calculateCosts();
  }

  void _calculateCosts() {
    costPerPerson = widget.totalCost / (widget.participants + 1); // +1 for driver
    driverShare = costPerPerson;
    passengerShare = costPerPerson;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cost Sharing')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('Trip Cost Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Cost:'),
                        Text('LKR ${widget.totalCost.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total People:'),
                        Text('${widget.participants + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Cost per Person:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('LKR ${costPerPerson.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Individual Shares', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _buildShareItem('Driver', driverShare, Icons.person),
                    ...List.generate(
                      widget.participants,
                      (index) => _buildShareItem('Passenger ${index + 1}', passengerShare, Icons.person_outline),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _confirmCostSharing(),
                child: const Text('Confirm Cost Sharing'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareItem(String person, double amount, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(child: Text(person)),
          Text('LKR ${amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _confirmCostSharing() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cost Sharing Confirmed'),
        content: Text('Each person pays LKR ${costPerPerson.toStringAsFixed(2)}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}