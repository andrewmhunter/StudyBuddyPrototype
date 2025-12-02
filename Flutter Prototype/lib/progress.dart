import 'package:flutter/material.dart';
import 'models.dart';

/// =============================================================
/// MAIN PROGRESS PAGE
/// =============================================================
class ProgressPage extends StatelessWidget {
  final List<Course> courses;

  const ProgressPage({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
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
                child: courses.isEmpty
                    ? const Center(
                  child: Text(
                    "No courses added yet.",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
                    : ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
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
                          Text(course.name,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(course.semester,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 8),
                          const Text("Study Sessions: 0 / 6"),
                          const Text("Topics Mastered: 0 / 4"),
                          const SizedBox(height: 8),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          StudyProgressPage(course: course),
                                    ),
                                  );
                                },
                                child: const Text("View"),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ExamFeedbackPage(course: course),
                                    ),
                                  );
                                },
                                child: const Text("Feedback"),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _smallCircle(label: 'Daily Progress', percent: 0.8),
                  _smallCircle(label: 'Weekly Progress', percent: 0.3),
                  Column(
                    children: const [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(height: 4),
                      Text('Streak: 5 days', style: TextStyle(fontSize: 11)),
                    ],
                  ),
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
              CircularProgressIndicator(value: percent, strokeWidth: 5),
              Text('$p%'),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11))
      ],
    );
  }
}

/// =============================================================
/// STUDY PROGRESS PAGE  (modern card styling)
/// =============================================================
class StudyProgressPage extends StatefulWidget {
  final Course course;

  const StudyProgressPage({super.key, required this.course});

  @override
  State<StudyProgressPage> createState() => _StudyProgressPageState();
}

class _StudyProgressPageState extends State<StudyProgressPage> {
  // Interactive ratings for topics
  int ratingDesign = 2;
  int ratingUseCase = 3;
  int ratingHeuristic = 2;

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Scaffold(
      appBar: AppBar(
        title: Text("${course.code} – Midterm"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Study Progress",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // ===============================
              // STUDY STATS CARD
              // ===============================
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _statCircle("Study Sessions", 3, 6),
                    _statCircle("Study Hours", 2.75, 5),
                    _statCircle("Topics Mastered", 2, 6),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ===============================
              // NEXT SESSION CARD
              // ===============================
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.calendar_today, size: 20),
                        SizedBox(width: 8),
                        Text("3 days"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Icon(Icons.access_time, size: 20),
                        SizedBox(width: 8),
                        Text("30 minutes"),
                      ],
                    ),
                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("Start"),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ===============================
              // TOPICS AND UNDERSTANDING LEVEL
              // ===============================
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Topics Overview - Level of Understanding",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const SizedBox(height: 14),

              _ratingCard(
                "Design Lifecycle",
                ratingDesign,
                    (v) => setState(() => ratingDesign = v),
              ),

              _ratingCard(
                "Use Case Task Analysis",
                ratingUseCase,
                    (v) => setState(() => ratingUseCase = v),
              ),

              _ratingCard(
                "Heuristic Evaluation",
                ratingHeuristic,
                    (v) => setState(() => ratingHeuristic = v),
              ),

              const SizedBox(height: 26),

              const Text(
                "6 days to midterm.",
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------
  // Stats Circle Widget (matches screenshot style)
  // ---------------------------------------------
  Widget _statCircle(String label, double done, double total) {
    final percent = done / total;
    return Column(
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: percent,
                strokeWidth: 6,
              ),
              Text(
                "${done.toInt()}/${total.toInt()}",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------
  // Stylish Rating Row in Card Container
  // ---------------------------------------------
  Widget _ratingCard(
      String title, int selectedValue, Function(int) onSelect) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FB),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (i) {
                final isSelected = (i + 1) == selectedValue;

                return GestureDetector(
                  onTap: () => onSelect(i + 1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                        vertical: 6, horizontal: 14),
                    decoration: BoxDecoration(
                      color:
                      isSelected ? Colors.blue : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${i + 1}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}


class ExamFeedbackPage extends StatefulWidget {
  final Course course;

  const ExamFeedbackPage({super.key, required this.course});

  @override
  State<ExamFeedbackPage> createState() => _ExamFeedbackPageState();
}

class _ExamFeedbackPageState extends State<ExamFeedbackPage> {
  // Interactive ratings
  int overall = 4;
  int coverage = 3;
  int preparedness = 1;

  // Editable feedback
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Scaffold(
      appBar: AppBar(
        title: Text("${course.code} – Final Exam"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Exam Feedback",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Rate how you think the test went 1 (bad) – 5 (great)",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // --- RATING CARDS ---
              _ratingCard("Overall", overall,
                      (v) => setState(() => overall = v)),
              _ratingCard("Study Buddy Covered Everything", coverage,
                      (v) => setState(() => coverage = v)),
              _ratingCard("You Felt Prepared", preparedness,
                      (v) => setState(() => preparedness = v)),

              const SizedBox(height: 20),

              // --- Open Ended Feedback ---
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Open Ended Feedback:",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: feedbackController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write your thoughts here...",
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Finish button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Finish",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // RATING CARD UI
  Widget _ratingCard(
      String title, int selectedValue, Function(int) onSelect) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (i) {
                final isSelected = (i + 1) == selectedValue;

                return GestureDetector(
                  onTap: () => onSelect(i + 1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                        vertical: 6, horizontal: 14),
                    decoration: BoxDecoration(
                      color:
                      isSelected ? Colors.blue : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${i + 1}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
