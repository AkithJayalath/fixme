import 'package:fixme/widgets/search_screen/offers_section.dart';
import 'package:fixme/widgets/search_screen/top_picks_section.dart';
import 'package:fixme/widgets/search_screen/service_categories_section.dart';
import 'package:fixme/widgets/search_screen/date_time_section.dart';
import 'package:fixme/widgets/search_screen/previous_services_section.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  final List<String> serviceCategories;
  final Map<String, String> categoryIcons;
  final String selectedCategory;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final Function(String) onCategorySelected;
  final VoidCallback onSelectDate;
  final VoidCallback onSelectTime;
  final VoidCallback? onSearchPressed;

  const SearchView({
    super.key,
    required this.serviceCategories,
    required this.categoryIcons,
    required this.selectedCategory,
    required this.selectedDate,
    required this.selectedTime,
    required this.onCategorySelected,
    required this.onSelectDate,
    required this.onSelectTime,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OffersSection(),
          const TopPicksSection(),
          ServiceCategoriesSection(
            serviceCategories: serviceCategories,
            categoryIcons: categoryIcons,
            selectedCategory: selectedCategory,
            onCategorySelected: onCategorySelected,
            onCategoryChanged: onCategorySelected, // Using the same callback
          ),
          DateTimeSection(
            selectedDate: selectedDate,
            selectedTime: selectedTime,
            onSelectDate: onSelectDate,
            onSelectTime: onSelectTime,
          ),
          _buildSearchButton(),
          PreviousServicesSection(
            serviceCategories: serviceCategories,
            categoryIcons: categoryIcons,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onSearchPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Search Services',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}