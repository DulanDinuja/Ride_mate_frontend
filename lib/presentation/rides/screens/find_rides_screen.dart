import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/liquid_background.dart';

class FindRidesScreen extends StatefulWidget {
  const FindRidesScreen({super.key});

  @override
  State<FindRidesScreen> createState() => _FindRidesScreenState();
}

class _FindRidesScreenState extends State<FindRidesScreen> {
  String? _genderFilter;
  RangeValues _priceRange = const RangeValues(0, 5000);
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: 'Find Rides',
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cyan.withOpacity(0.2),
              ),
              child: const Icon(Icons.filter_list),
            ),
            onPressed: _showFilters,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LiquidBackground(
        bubbleCount: 6,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: GlassContainer(
                  padding: const EdgeInsets.all(16),
                  blur: 15,
                  opacity: 0.15,
                  child: Column(
                    children: [
                      GlassTextField(
                        controller: _fromController,
                        hintText: 'Starting location',
                        labelText: 'From',
                        prefixIcon: Icons.my_location,
                      ),
                      const SizedBox(height: 12),
                      GlassTextField(
                        controller: _toController,
                        hintText: 'Destination',
                        labelText: 'To',
                        prefixIcon: Icons.location_on,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 10,
                  itemBuilder: (context, index) => _buildRideCard(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRideCard() {
    return LiquidGlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.cyan, AppColors.cyanBright],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyan.withOpacity(0.3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(Icons.person, color: AppColors.textPrimary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sanjaya Kulathunga',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const Text(
                          ' 4.8',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.accent, AppColors.accentLight],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.3),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Text(
                  'LKR 500',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.cyan.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Colombo Fort',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
              ),
              const Text(
                'Today, 8:00 AM',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Kandy City',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.cyan.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.cyan.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: const Text(
                  '3 seats left',
                  style: TextStyle(
                    color: AppColors.cyan,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary.withOpacity(0.9),
                  AppColors.primaryDark.withOpacity(0.95),
                ],
              ),
              border: Border(
                top: BorderSide(
                  color: AppColors.cyan.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.textSecondary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  GlassContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    blur: 15,
                    opacity: 0.15,
                    child: DropdownButton<String>(
                      value: _genderFilter,
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Text(
                        'Gender Preference',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      dropdownColor: AppColors.primary,
                      items: ['Male', 'Female', 'Any']
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: const TextStyle(color: AppColors.textPrimary),
                                ),
                              ))
                          .toList(),
                      onChanged: (v) => setState(() => _genderFilter = v),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassContainer(
                    padding: const EdgeInsets.all(16),
                    blur: 15,
                    opacity: 0.15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price Range',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        RangeSlider(
                          values: _priceRange,
                          min: 0,
                          max: 5000,
                          activeColor: AppColors.cyan,
                          inactiveColor: AppColors.textSecondary.withOpacity(0.3),
                          onChanged: (v) => setState(() => _priceRange = v),
                        ),
                        Text(
                          'LKR ${_priceRange.start.round()} - LKR ${_priceRange.end.round()}',
                          style: const TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  GlassButton(
                    text: 'Apply Filters',
                    onPressed: () => Navigator.pop(context),
                    icon: Icons.check,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }
}
