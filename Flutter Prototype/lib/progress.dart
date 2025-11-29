import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'course': 'CSCI 4620U – Human-Computer Interaction',
        'exam': 'Midterm – Oct 5',
        'sessions': '3/6',
        'topics': '2/4'
      },
      {
        'course': 'CSCI 3310U – Systems Programming',
        'exam': 'Final Exam – Dec 3',
        'sessions': '4/12',
        'topics': '3/12'
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Progress',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final item = items[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['course']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['exam']!,
                            style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text('Study Sessions: ${item['sessions']}'),
                          Text('Topics Mastered: ${item['topics']}'),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('View'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _smallCircle(label: 'Daily Progress', percent: 0.8),
                  _smallCircle(label: 'Weekly Progress', percent: 0.3),
                  Column(
                    children: const [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(height: 4),
                      Text('Streak: 5 days',
                          style: TextStyle(fontSize: 11)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _smallCircle({required String label, required double percent}) {
    final p = (percent * 100).round();
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: percent,
                strokeWidth: 5,
              ),
              Text('$p%'),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
