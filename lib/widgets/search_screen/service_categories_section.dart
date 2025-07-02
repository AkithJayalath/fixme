import 'package:flutter/material.dart';

class ServiceCategoriesSection extends StatelessWidget {
  final List<String> serviceCategories;
  final Map<String, String> categoryIcons;
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final Function(String) onCategoryChanged;

  const ServiceCategoriesSection({
    super.key,
    required this.serviceCategories,
    required this.categoryIcons,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Service Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: serviceCategories.length,
          itemBuilder: (context, index) {
            final category = serviceCategories[index];
            final isSelected = selectedCategory == category;
            
            return GestureDetector(
              onTap: () => onCategorySelected(category),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: isSelected 
                      ? Border.all(color: Colors.blue, width: 2)
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      categoryIcons[category] ?? '🔧',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      category,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.blue : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}