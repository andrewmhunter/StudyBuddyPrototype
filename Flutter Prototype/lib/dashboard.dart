import 'package:flutter/material.dart';
import 'models.dart';
import 'study.dart'; // <-- KEEPING THIS, OK IF UNUSED

class DashboardPage extends StatelessWidget {
  final Availability? availability;
  final VoidCallback onEditAvailability;

  // ↓↓↓ ADDED THIS (minimal change)
  final VoidCallback onStartStudy; // <-- ADDED

  const DashboardPage({
    super.key,
    required this.availability,
    required this.onEditAvailability,
    required this.onStartStudy, // <-- ADDED
  });

  @override
  Widget build(BuildContext context) {
    String availabilityText;
    if (availability == null) {
      availabilityText = 'Set when you are available to study';
    } else {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      final selected =
      availability!.days.map((d) => days[d]).toList(growable: false);
      availabilityText =
      '${selected.join(', ')} · ${availability!.start.format(context)} – ${availability!.end.format(context)}';
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          const Text(
            'Dashboard',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _sectionHeader('Upcoming Study Sessions'),
                  const SizedBox(height: 8),
                  _sessionCard(
                    title: 'CSCI 4620U - Final Exam',
                    subtitle: 'Design Lifecycle',
                    when: 'Today',
                    duration: '60 minutes',
                    context: context,
                  ),
                  _sessionCard(
                    title: 'CSCI 3310U - Final Exam',
                    subtitle: 'Memory Management',
                    when: 'Today',
                    duration: '60 minutes',
                    context: context,
                  ),
                  _sessionCard(
                    title: 'CSCI 4620U - Final Exam',
                    subtitle: 'Use Case Task Analysis',
                    when: '3 days',
                    duration: '30 minutes',
                    context: context,
                  ),
                  _sessionCard(
                    title: 'CSCI 3310U - Final Exam',
                    subtitle: 'Banker\'s Algorithm',
                    when: '3 days',
                    duration: '90 minutes',
                    context: context,
                  ),
                  const SizedBox(height: 24),
                  _sectionHeader('Progress'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _ProgressCircle(label: 'Daily Progress', percent: 0.8),
                      _ProgressCircle(label: 'Weekly Progress', percent: 0.3),
                      _StreakCard(streakDays: 5),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      '"Success is the sum of small efforts repeated day-in and day-out." - Robert Collier',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: onEditAvailability,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Availability'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    availabilityText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _sessionCard({
    required String title,
    required String subtitle,
    required String when,
    required String duration,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
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
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      when,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      duration,
                      style:
                      const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// 🔥 MINIMAL CHANGE: call onStartStudy()
          SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: onStartStudy, // <-- CHANGED ONLY THIS
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 0),
              ),
              child: const Text('Start'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressCircle extends StatelessWidget {
  final String label;
  final double percent;

  const _ProgressCircle({required this.label, required this.percent});

  @override
  Widget build(BuildContext context) {
    final percentage = (percent * 100).round();
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
              Text('$percentage%'),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _StreakCard extends StatelessWidget {
  final int streakDays;

  const _StreakCard({required this.streakDays});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.star, size: 40, color: Colors.amber),
        const SizedBox(height: 4),
        Text(
          'Streak: $streakDays days',
          style: const TextStyle(fontSize: 11),
        ),
      ],
    );
  }
}

class AvailabilityPage extends StatefulWidget {
  final Availability? initialAvailability;

  const AvailabilityPage({super.key, this.initialAvailability});

  @override
  State<AvailabilityPage> createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  final List<String> _dayLabels = const [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  late List<bool> _selectedDays;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();
    _selectedDays = List<bool>.filled(7, false);
    _startTime = const TimeOfDay(hour: 9, minute: 0);
    _endTime = const TimeOfDay(hour: 17, minute: 0);

    if (widget.initialAvailability != null) {
      for (final d in widget.initialAvailability!.days) {
        if (d >= 0 && d < 7) _selectedDays[d] = true;
      }
      _startTime = widget.initialAvailability!.start;
      _endTime = widget.initialAvailability!.end;
    }
  }

  Future<void> _pickTime(bool isStart) async {
    final initial = isStart ? _startTime : _endTime;
    final result = await showTimePicker(
      context: context,
      initialTime: initial,
    );
    if (result != null) {
      setState(() {
        if (isStart) {
          _startTime = result;
        } else {
          _endTime = result;
        }
      });
    }
  }

  void _save() {
    final days = <int>[];
    for (var i = 0; i < _selectedDays.length; i++) {
      if (_selectedDays[i]) days.add(i);
    }
    if (days.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select at least one day')),
      );
      return;
    }
    Navigator.of(context).pop(
      Availability(
        days: days,
        start: _startTime,
        end: _endTime,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Availability'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select days you are available',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            ToggleButtons(
              isSelected: _selectedDays,
              onPressed: (index) {
                setState(() {
                  _selectedDays[index] = !_selectedDays[index];
                });
              },
              borderRadius: BorderRadius.circular(12),
              children: _dayLabels
                  .map(
                    (d) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  child: Text(d),
                ),
              )
                  .toList(),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Time range',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _timeButton(
                    label: 'Start\n${_startTime.format(context)}',
                    onTap: () => _pickTime(true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _timeButton(
                    label: 'End\n${_endTime.format(context)}',
                    onTap: () => _pickTime(false),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _save,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }
}
