import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  final bool showResults;
  final VoidCallback onBackPressed;
  final VoidCallback onFiltersPressed;
  final String selectedServiceType;
  final Function(String) onServiceTypeChanged;

  const SearchHeader({
    super.key,
    required this.showResults,
    required this.onBackPressed,
    required this.onFiltersPressed,
    required this.selectedServiceType,
    required this.onServiceTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (showResults)
                IconButton(
                  onPressed: onBackPressed,
                  icon: const Icon(Icons.arrow_back),
                ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search services...',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
              if (showResults) ...[
                const SizedBox(width: 12),
                IconButton(
                  onPressed: onFiltersPressed,
                  icon: const Icon(Icons.tune),
                ),
              ],
            ],
          ),
          if (!showResults) ...[
            const SizedBox(height: 16),
            _buildServiceTypeSelector(),
          ],
        ],
      ),
    );
  }

  Widget _buildServiceTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onServiceTypeChanged('Technician'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: selectedServiceType == 'Technician' 
                    ? Colors.blue 
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Technician',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selectedServiceType == 'Technician' 
                      ? Colors.white 
                      : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => onServiceTypeChanged('Service Center'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: selectedServiceType == 'Service Center' 
                    ? Colors.blue 
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Service Center',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selectedServiceType == 'Service Center' 
                      ? Colors.white 
                      : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}