import 'package:fixme/widgets/search_screen/top_pick_card.dart';
import 'package:flutter/material.dart';

class TopPicksSection extends StatelessWidget {
  const TopPicksSection({super.key});

  final List<Map<String, dynamic>> topPicks = const [
    {
      'name': 'ElectroFix Pro',
      'rating': 4.7,
      'reviews': 2000,
      'time': '30 min',
      'fee': 'Rs.99',
      'offers': '2 Offers available',
    },
    {
      'name': 'PlumbMaster',
      'rating': 4.4,
      'reviews': 1500,
      'time': '45 min',
      'fee': 'Rs.149',
      'offers': null,
    },
    {
      'name': 'AutoCare Center',
      'rating': 4.6,
      'reviews': 3200,
      'time': '60 min',
      'fee': 'Rs.199',
      'offers': '3 Offers available',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Top picks: Popular Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('See all'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: topPicks.length,
            itemBuilder: (context, index) {
              return TopPickCard(
                name: topPicks[index]['name'],
                rating: topPicks[index]['rating'],
                reviews: topPicks[index]['reviews'],
                time: topPicks[index]['time'],
                fee: topPicks[index]['fee'],
                offers: topPicks[index]['offers'],
              );
            },
          ),
        ),
      ],
    );
  }
}