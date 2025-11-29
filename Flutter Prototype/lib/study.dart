import 'package:flutter/material.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = [
      {
        'course': 'CSCI 4620U - Final Exam',
        'topic': 'Design Lifecycle',
        'day': 'Today',
        'duration': '60 minutes',
      },
      {
        'course': 'CSCI 3310U - Final Exam',
        'topic': 'Memory Management',
        'day': 'Today',
        'duration': '30 minutes',
      },
      {
        'course': 'CSCI 4620U - Final Exam',
        'topic': 'Use Case Task Analysis',
        'day': '3 days',
        'duration': '30 minutes',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Study Sessions",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: ListView.builder(
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    final s = sessions[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  s['course']!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text(s['topic']!,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.grey)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      s['day']!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      s['duration']!,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          /// Start Button
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const StudySessionFlowMockPage(),
                                ),
                              );
                            },
                            child: const Text("Start"),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// STUDY FLOW — Mockup

class StudySessionFlowMockPage extends StatelessWidget {
  const StudySessionFlowMockPage({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {"label": "Review Material", "time": "10 minutes"},
      {"label": "Flash Cards", "time": "10 minutes"},
      {"label": "Open Ended Problems", "time": "25 minutes"},
      {"label": "Quiz", "time": "15 minutes"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("CSCI 4620U - Final Exam")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Progress Bar
            LinearProgressIndicator(
              value: 0.25,
              minHeight: 6,
            ),
            const SizedBox(height: 16),

            /// Steps
            for (var step in steps)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.blueGrey[400]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(step['label']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text(step['time']!,
                                style:
                                const TextStyle(color: Colors.grey)),
                          ]),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Start"),
                    )
                  ],
                ),
              ),

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style:
                ElevatedButton.styleFrom(backgroundColor: Colors.grey[400]),
                onPressed: () {},
                child: const Text("Finish Session"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
