import 'package:fixme/widgets/search_screen/search_header.dart';
import 'package:fixme/widgets/search_screen/search_view.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String selectedServiceType = 'Technician';
  String selectedCategory = '';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool showResults = false;
  
  // Service categories data
  final List<String> serviceCategories = [
    'Plumbing',
    'Electrical',
    'Cleaning',
    'Carpentry',
    'Painting',
    'AC Repair',
    'Appliance Repair',
    'Gardening',
  ];

  final Map<String, String> categoryIcons = {
    'Plumbing': '🔧',
    'Electrical': '⚡',
    'Cleaning': '🧽',
    'Carpentry': '🔨',
    'Painting': '🎨',
    'AC Repair': '❄️',
    'Appliance Repair': '🔌',
    'Gardening': '🌱',
  };
  
  // Filter variables
  double minRating = 0.0;
  double maxDistance = 20.0;
  RangeValues priceRange = const RangeValues(500, 5000);
  int minExperience = 0;
  bool verifiedOnly = false;
  bool weekendAvailable = false;
  bool eveningHours = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SearchHeader(
              showResults: showResults,
              onBackPressed: () {
                setState(() {
                  showResults = false;
                });
              },
              onFiltersPressed: _showFilters,
              selectedServiceType: selectedServiceType,
              onServiceTypeChanged: (type) {
                setState(() {
                  selectedServiceType = type;
                });
              },
            ),
            Expanded(
              child: showResults 
                ? SearchResults(
                    selectedServiceType: selectedServiceType,
                    selectedCategory: selectedCategory,
                    selectedDate: selectedDate,
                    selectedTime: selectedTime,
                  )
                : SearchView(
                    serviceCategories: serviceCategories,
                    categoryIcons: categoryIcons,
                    selectedCategory: selectedCategory,
                    selectedDate: selectedDate,
                    selectedTime: selectedTime,
                    onCategorySelected: (category) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    onSelectDate: _selectDate,
                    onSelectTime: _selectTime,
                    onSearchPressed: selectedCategory.isNotEmpty ? _performSearch : null,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _performSearch() {
    setState(() {
      showResults = true;
    });
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        minRating: minRating,
        maxDistance: maxDistance,
        priceRange: priceRange,
        minExperience: minExperience,
        verifiedOnly: verifiedOnly,
        weekendAvailable: weekendAvailable,
        eveningHours: eveningHours,
        onFiltersChanged: (filters) {
          setState(() {
            minRating = filters['minRating'];
            maxDistance = filters['maxDistance'];
            priceRange = filters['priceRange'];
            minExperience = filters['minExperience'];
            verifiedOnly = filters['verifiedOnly'];
            weekendAvailable = filters['weekendAvailable'];
            eveningHours = filters['eveningHours'];
          });
        },
      ),
    );
  }
}

// Basic SearchResults widget since you don't have one
class SearchResults extends StatelessWidget {
  final String selectedServiceType;
  final String selectedCategory;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;

  const SearchResults({
    super.key,
    required this.selectedServiceType,
    required this.selectedCategory,
    this.selectedDate,
    this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Results for $selectedCategory',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (selectedDate != null || selectedTime != null)
            Text(
              'Scheduled for: ${selectedDate != null ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}' : 'Any date'} ${selectedTime != null ? 'at ${selectedTime!.format(context)}' : ''}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Mock data
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.blue[100],
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Service Provider ${index + 1}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '$selectedCategory Specialist',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    Text(
                                      '${4.0 + (index * 0.2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Rs. ${1000 + (index * 200)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Experienced ${selectedCategory.toLowerCase()} service provider with ${2 + index} years of experience.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {},
                                child: const Text('View Details'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Book Now'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
                  _buildRatingFilter(),
                  const SizedBox(height: 24),
                  _buildDistanceFilter(),
                  const SizedBox(height: 24),
                  _buildPriceRangeFilter(),
                  const SizedBox(height: 24),
                  _buildExperienceFilter(),
                  const SizedBox(height: 24),
                  _buildOtherFilters(),
                ],
              ),
            ),
          ),
          _buildFilterActions(),
        ],
      ),
    );
  }

  Widget _buildRatingFilter() {
    return Column(
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
      ],
    );
  }

  Widget _buildDistanceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  Widget _buildPriceRangeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  Widget _buildExperienceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  Widget _buildOtherFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    );
  }

  Widget _buildFilterActions() {
    return Container(
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
              onPressed: () {
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
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
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
}