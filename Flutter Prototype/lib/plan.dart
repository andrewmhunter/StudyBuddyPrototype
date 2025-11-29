import 'package:flutter/material.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = [
      {
        'course': 'CSCI 4620U - Human-Computer Interaction',
        'exam': 'Midterm - Oct 5'
      },
      {
        'course': 'CSCI 4620U - Human-Computer Interaction',
        'exam': 'Final Exam - Dec 4'
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// Title
              const Text(
                "Study Plans",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              /// List of study plans
              Expanded(
                child: ListView.builder(
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    final p = plans[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p['course']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            p['exam']!,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),

                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const StudyPlanDetailPage(),
                                  ),
                                );
                              },
                              child: const Text("View"),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

              /// Create plan button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Create Plan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudyPlanDetailPage extends StatelessWidget {
  const StudyPlanDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CSCI 4620U - Study Plan"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Test Info Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F7FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Tabs (Midterm / Final / Other)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _pillButton("Midterm", true),
                      _pillButton("Final Exam", false),
                      _pillButton("Other", false),
                    ],
                  ),
                  const SizedBox(height: 16),

                  /// Date, Time, Location
                  Row(
                    children: [
                      Expanded(
                        child: _infoTile("Apr 1, 2025"),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _infoTile("10:00 AM"),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _infoTile("12:00 PM"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  _infoTile("SCI 1350"),
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text("Edit"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Study Plan Information
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Study Plan Information",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: const [
                      Icon(Icons.access_time, size: 20),
                      SizedBox(width: 8),
                      Text("Study Time Goal: 20 Hours"),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Text("Study Materials:",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 10),
                  _materialChip("Lecture01.pdf"),
                  _materialChip("Lecture02.pdf"),
                  _materialChip("Lab01.pdf"),
                  const SizedBox(height: 16),

                  const Text("Test Content:",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  const Text(
                    "Topics covered: Lecture 9–12. You should focus on the first two lectures (L9–L10) "
                        "and main core concepts. The questions will be multiple choice, short answer, and "
                        "code tracing questions.",
                    style: TextStyle(fontSize: 13),
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Edit"),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pillButton(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: active ? Colors.blue : Colors.white,
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: active ? Colors.white : Colors.blue,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _infoTile(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(text),
    );
  }

  Widget _materialChip(String name) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(name),
    );
  }
}
