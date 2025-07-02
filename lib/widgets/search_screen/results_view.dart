import 'package:flutter/material.dart';
import 'package:fixme/widgets/search_screen/results_card.dart';

class ResultsView extends StatelessWidget {
  final String selectedServiceType;
  final String selectedCategory;

  const ResultsView({
    super.key,
    required this.selectedServiceType,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[50],
          child: Row(
            children: [
              Text(
                'Found 24 ${selectedServiceType.toLowerCase()}s',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                selectedCategory,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 10,
            itemBuilder: (context, index) {
              return ResultCard(index: index);
            },
          ),
        ),
      ],
    );
  }
}