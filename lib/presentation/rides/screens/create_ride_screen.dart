import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/ride_model_complete.dart';
import '../../providers/ride_provider.dart';

class CreateRideScreen extends StatefulWidget {
  const CreateRideScreen({super.key});

  @override
  State<CreateRideScreen> createState() => _CreateRideScreenState();
}

class _CreateRideScreenState extends State<CreateRideScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _totalCostController = TextEditingController();
  final _seatsController = TextEditingController(text: '3');
  DateTime _selectedDate = DateTime.now().add(const Duration(hours: 1));
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final availableSeats = int.tryParse(_seatsController.text) ?? 3;
    final totalCost = double.tryParse(_totalCostController.text) ?? 0;
    final costPerPerson = totalCost > 0 ? totalCost / (availableSeats + 1) : 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Create Ride')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _fromController,
              decoration: const InputDecoration(
                labelText: 'From',
                border: OutlineInputBorder(),
              ),
              validator: (v) => v?.isEmpty == true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _toController,
              decoration: const InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
              ),
              validator: (v) => v?.isEmpty == true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _totalCostController,
                    decoration: const InputDecoration(
                      labelText: 'Total Trip Cost (LKR)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) => double.tryParse(v ?? '') == null ? 'Invalid amount' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _seatsController,
                    decoration: const InputDecoration(
                      labelText: 'Available Seats',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) => int.tryParse(v ?? '') == null ? 'Invalid number' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (costPerPerson > 0)
              Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Cost per person: LKR ${costPerPerson.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Date'),
              subtitle: Text('${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                if (date != null) setState(() => _selectedDate = date);
              },
            ),
            ListTile(
              title: const Text('Time'),
              subtitle: Text(_selectedTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final time = await showTimePicker(context: context, initialTime: _selectedTime);
                if (time != null) setState(() => _selectedTime = time);
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _createRide(),
              child: const Text('Create Ride'),
            ),
          ],
        ),
      ),
    );
  }

  void _createRide() {
    if (!_formKey.currentState!.validate()) return;

    final ride = RideModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      starterId: 'current_user_id',
      starterName: 'Current User',
      starterPhotoUrl: '',
      starterRating: 4.5,
      origin: LocationModel(
        address: _fromController.text,
        latitude: 0.0,
        longitude: 0.0,
      ),
      destination: LocationModel(
        address: _toController.text,
        latitude: 0.0,
        longitude: 0.0,
      ),
      scheduledDateTime: DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      ),
      totalSeats: int.parse(_seatsController.text),
      availableSeats: int.parse(_seatsController.text),
      totalCost: double.parse(_totalCostController.text),
      costPerSeat: double.parse(_totalCostController.text) / (int.parse(_seatsController.text) + 1),
      status: RideStatus.open,
      vehicle: VehicleInfo(
        make: 'Toyota',
        model: 'Prius',
        color: 'White',
        licensePlate: 'ABC-1234',
        type: 'Sedan',
      ),
      participants: [],
      joinRequests: [],
      preferences: RidePreferences(
        genderPreference: GenderPreference.any,
      ),
      createdAt: DateTime.now(),
    );

    context.read<RideProvider>().createRide(ride);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ride created successfully!')),
    );
    
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _totalCostController.dispose();
    _seatsController.dispose();
    super.dispose();
  }
}