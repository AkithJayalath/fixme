import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final double minRating;
  final double maxDistance;
  final RangeValues priceRange;
  final int minExperience;
  final bool verifiedOnly;
  final bool weekendAvailable;
  final bool eveningHours;
  final Function(Map<String, dynamic>) onFiltersChanged;

  const FilterBottomSheet({
    super.key,
    required this.minRating,
    required this.maxDistance,
    required this.priceRange,
    required this.minExperience,
    required this.verifiedOnly,
    required this.weekendAvailable,
    required this.eveningHours,
    required this.onFiltersChanged,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late double minRating;
  late double maxDistance;
  late RangeValues priceRange;
  late int minExperience;
  late bool verifiedOnly;
  late bool weekendAvailable;
  late bool eveningHours;

  @override
  void initState() {
    super.initState();
    minRating = widget.minRating;
    maxDistance = widget.maxDistance;
    priceRange = widget.priceRange;
    minExperience = widget.minExperience;
    verifiedOnly = widget.verifiedOnly;
    weekendAvailable = widget.weekendAvailable;
    eveningHours = widget.eveningHours;
  }

  void _clearAllFilters() {
    setState(() {
      minRating = 0.0;
      maxDistance = 20.0;
      priceRange = const RangeValues(500, 5000);
      minExperience = 0;
      verifiedOnly = false;
      weekendAvailable = false;
      eveningHours = false;
    });
  }

  void _applyFilters() {
    widget.onFiltersChanged({
      'minRating': minRating,
      'maxDistance': maxDistance,
      'priceRange': priceRange,
      'minExperience': minExperience,
      'verifiedOnly': verifiedOnly,
      'weekendAvailable': weekendAvailable,
      'eveningHours': eveningHours,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: _clearAllFilters,
                  child: const Text('Clear All'),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rating',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [4.5, 4.0, 3.5, 3.0].map((rating) {
                      final isSelected = minRating == rating;
                      return FilterChip(
                        label: Text('${rating}★ & up'),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            minRating = selected ? rating : 0.0;
                          });
                        },
                        selectedColor: Colors.blue.withOpacity(0.2),
                        checkmarkColor: Colors.blue,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Distance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: maxDistance,
                    min: 1.0,
                    max: 50.0,
                    divisions: 49,
                    label: '${maxDistance.round()} km',
                    onChanged: (value) {
                      setState(() {
                        maxDistance = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Price Range',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RangeSlider(
                    values: priceRange,
                    min: 0,
                    max: 10000,
                    divisions: 100,
                    labels: RangeLabels(
                      'Rs.${priceRange.start.round()}',
                      'Rs.${priceRange.end.round()}',
                    ),
                    onChanged: (values) {
                      setState(() {
                        priceRange = values;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Experience Level',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [0, 1, 3, 5, 10].map((years) {
                      final isSelected = minExperience == years;
                      return FilterChip(
                        label: Text(years == 0 ? 'Any' : '${years}+ years'),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            minExperience = selected ? years : 0;
                          });
                        },
                        selectedColor: Colors.blue.withOpacity(0.2),
                        checkmarkColor: Colors.blue,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Other Filters',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    title: const Text('Verified Providers Only'),
                    subtitle: const Text('Show only verified service providers'),
                    value: verifiedOnly,
                    onChanged: (value) {
                      setState(() {
                        verifiedOnly = value;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  SwitchListTile(
                    title: const Text('Weekend Availability'),
                    subtitle: const Text('Available on weekends'),
                    value: weekendAvailable,
                    onChanged: (value) {
                      setState(() {
                        weekendAvailable = value;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  SwitchListTile(
                    title: const Text('Evening Hours'),
                    subtitle: const Text('Available after 6 PM'),
                    value: eveningHours,
                    onChanged: (value) {
                      setState(() {
                        eveningHours = value;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _applyFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}