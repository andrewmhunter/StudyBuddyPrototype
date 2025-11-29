import 'package:flutter/material.dart';

void main() {
  runApp(const StudyBuddyApp());
}

// -------------------------------------------------------------
// Root app
// -------------------------------------------------------------

class StudyBuddyApp extends StatelessWidget {
  const StudyBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Buddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const AuthScreen(),
    );
  }
}

// -------------------------------------------------------------
// Shared styling
// -------------------------------------------------------------

class AppColors {
  static const primary = Color(0xFF0066FF);
  static const primaryLight = Color(0xFFEDF3FF);
  static const textDark = Color(0xFF1A1A1A);
  static const textLight = Color(0xFF7A7A7A);
  static const card = Colors.white;
  static const border = Color(0xFFE0E3EB);
}

class RoundedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const RoundedCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// -------------------------------------------------------------
// Simple data models
// -------------------------------------------------------------

class StudySession {
  final String courseName;
  final String examName;
  final String topic;
  final String when; // “Today”, “3 days”
  final String duration; // “60 minutes”

  StudySession({
    required this.courseName,
    required this.examName,
    required this.topic,
    required this.when,
    required this.duration,
  });
}

class Exam {
  final String label; // “Midterm – Oct 5”
  final DateTime dateTime;
  final String location;

  Exam({
    required this.label,
    required this.dateTime,
    required this.location,
  });
}

class Course {
  final String id;
  String name;
  String code;
  String semester;
  List<String> files;
  List<Exam> exams;
  List<StudySession> sessions;

  Course({
    required this.id,
    required this.name,
    required this.code,
    required this.semester,
    this.files = const [],
    this.exams = const [],
    this.sessions = const [],
  });

  Course copyWith({
    String? name,
    String? code,
    String? semester,
    List<String>? files,
    List<Exam>? exams,
    List<StudySession>? sessions,
  }) {
    return Course(
      id: id,
      name: name ?? this.name,
      code: code ?? this.code,
      semester: semester ?? this.semester,
      files: files ?? List.from(this.files),
      exams: exams ?? List.from(this.exams),
      sessions: sessions ?? List.from(this.sessions),
    );
  }
}

// -------------------------------------------------------------
// AUTH SCREEN (Login / Create Account)
// -------------------------------------------------------------

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  final _loginEmailController =
  TextEditingController(text: 'student@example.com');
  final _loginPasswordController = TextEditingController(text: 'password');

  final _signupNameController = TextEditingController();
  final _signupDobController = TextEditingController();
  final _signupPhoneController = TextEditingController();
  final _signupLevelController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();

  void _continueToApp() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainShell()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Study Buddy',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Your AI-powered study assistant',
                    style: TextStyle(color: AppColors.textLight),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      _AuthToggleButton(
                        label: 'Log In',
                        selected: isLogin,
                        onTap: () => setState(() => isLogin = true),
                      ),
                      const SizedBox(width: 12),
                      _AuthToggleButton(
                        label: 'Create Account',
                        selected: !isLogin,
                        onTap: () => setState(() => isLogin = false),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  RoundedCard(
                    padding: const EdgeInsets.all(20),
                    margin: EdgeInsets.zero,
                    child: isLogin ? _buildLoginForm() : _buildSignupForm(),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'By clicking ${isLogin ? 'Log In' : 'Get started'}, you accept our Terms of Use and Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Email', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: _loginEmailController,
          decoration: _inputDecoration('student@example.com', Icons.email),
        ),
        const SizedBox(height: 16),
        const Text('Password', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: _loginPasswordController,
          obscureText: true,
          decoration: _inputDecoration('Password', Icons.lock),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text('Forgot password'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _continueToApp,
            child: const Text('Log In'),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Create an Account',
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        _signupField(_signupNameController, 'Enter your Full Name', Icons.person),
        const SizedBox(height: 12),
        _signupField(
            _signupDobController, 'Enter your Date of Birth', Icons.cake),
        const SizedBox(height: 12),
        _signupField(
            _signupPhoneController, 'Enter your Phone Number', Icons.phone),
        const SizedBox(height: 12),
        _signupField(_signupLevelController, 'Select Level of Study',
            Icons.school, readOnly: true),
        const SizedBox(height: 12),
        _signupField(
            _signupEmailController, 'Enter your Email', Icons.email_outlined),
        const SizedBox(height: 12),
        _signupField(
          _signupPasswordController,
          'Enter your Password',
          Icons.lock_outline,
          obscure: true,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _continueToApp,
            child: const Text('Get started'),
          ),
        ),
      ],
    );
  }

  Widget _signupField(
      TextEditingController controller,
      String hint,
      IconData icon, {
        bool obscure = false,
        bool readOnly = false,
      }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscure,
      decoration: _inputDecoration(hint, icon),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: AppColors.textLight),
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF4F6FB),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    );
  }
}

class _AuthToggleButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _AuthToggleButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.primaryLight,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// MAIN SHELL with bottom navigation
// -------------------------------------------------------------

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  // Simple availability
  final Set<String> _availableDays = {'Mon', 'Wed', 'Fri'};
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 17, minute: 0);

  // In-memory course list
  List<Course> _courses = [];

  @override
  void initState() {
    super.initState();
    _courses = _seedCourses();
  }

  List<Course> _seedCourses() {
    final hci = Course(
      id: '1',
      name: 'CSCI 4620U • Human-Computer Interaction',
      code: 'CSCI 4620U',
      semester: 'Fall Semester 2025',
      files: ['Lecture01.pdf', 'Lecture02.pdf', 'Lab01.pdf'],
      exams: [
        Exam(
          label: 'Midterm – Oct 5',
          dateTime: DateTime(2025, 10, 5, 11, 0),
          location: 'SCI 1350',
        ),
        Exam(
          label: 'Final Exam – Dec 4',
          dateTime: DateTime(2025, 12, 4, 12, 0),
          location: 'SCI 1350',
        ),
      ],
    );

    final sys = Course(
      id: '2',
      name: 'CSCI 3310U • Systems Programming',
      code: 'CSCI 3310U',
      semester: 'Fall Semester 2025',
      files: ['Lecture03.pdf', 'Lecture04.pdf', 'Lab02.pdf'],
      exams: [
        Exam(
          label: 'Final Exam – Dec 3',
          dateTime: DateTime(2025, 12, 3, 9, 0),
          location: 'UA 2220',
        ),
      ],
    );

    final sessions = [
      StudySession(
        courseName: 'CSCI 4620U',
        examName: 'Final Exam',
        topic: 'Design Lifecycle',
        when: 'Today',
        duration: '60 minutes',
      ),
      StudySession(
        courseName: 'CSCI 3310U',
        examName: 'Final Exam',
        topic: 'Memory Management',
        when: 'Today',
        duration: '60 minutes',
      ),
      StudySession(
        courseName: 'CSCI 4620U',
        examName: 'Final Exam',
        topic: 'Use Case Task Analysis',
        when: '3 days',
        duration: '30 minutes',
      ),
      StudySession(
        courseName: 'CSCI 3310U',
        examName: 'Final Exam',
        topic: 'Banker’s Algorithm',
        when: '3 days',
        duration: '30 minutes',
      ),
    ];

    hci.sessions = sessions.where((s) => s.courseName == 'CSCI 4620U').toList();
    sys.sessions = sessions.where((s) => s.courseName == 'CSCI 3310U').toList();

    return [hci, sys];
  }

  void _openAvailabilityDialog() async {
    final result = await showDialog<_AvailabilityResult>(
      context: context,
      builder: (_) => AvailabilityDialog(
        days: _availableDays,
        start: _startTime,
        end: _endTime,
      ),
    );

    if (result != null) {
      setState(() {
        _availableDays
          ..clear()
          ..addAll(result.days);
        _startTime = result.start;
        _endTime = result.end;
      });
    }
  }

  void _addCourse(Course course) {
    setState(() {
      _courses = [..._courses, course];
    });
  }

  void _updateCourse(Course updated) {
    setState(() {
      _courses = _courses.map((c) => c.id == updated.id ? updated : c).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(
        allSessions: _courses.expand((c) => c.sessions).toList(),
        onAvailabilityTap: _openAvailabilityDialog,
      ),
      CoursesPage(
        courses: _courses,
        onAddCourse: _addCourse,
        onUpdateCourse: _updateCourse,
      ),
      const PlaceholderPage(title: 'Study Plans'),
      const PlaceholderPage(title: 'Study Sessions'),
      ProgressPage(courses: _courses),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textLight,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_outlined),
            label: 'Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule_outlined),
            label: 'Study',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// DASHBOARD
// -------------------------------------------------------------

class DashboardPage extends StatelessWidget {
  final List<StudySession> allSessions;
  final VoidCallback onAvailabilityTap;

  const DashboardPage({
    super.key,
    required this.allSessions,
    required this.onAvailabilityTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                'Dashboard',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_outline),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              RoundedCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upcoming Study Sessions',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ...allSessions.map((s) => _SessionRow(session: s)),
                  ],
                ),
              ),
              RoundedCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _ProgressCircle(label: 'Daily Progress', value: 0.8),
                    _ProgressCircle(label: 'Weekly Progress', value: 0.3),
                    _StreakCard(),
                  ],
                ),
              ),
              RoundedCard(
                child: Column(
                  children: const [
                    Text(
                      '"Success is the sum of small efforts repeated day-in and day-out."',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '- Robert Collier',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onAvailabilityTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Availability'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SessionRow extends StatelessWidget {
  final StudySession session;

  const _SessionRow({required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                session.when,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(session.duration,
                  style: const TextStyle(color: AppColors.textLight)),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${session.courseName} - ${session.examName}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  session.topic,
                  style: const TextStyle(
                    color: AppColors.textLight,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }
}

class _ProgressCircle extends StatelessWidget {
  final String label;
  final double value;

  const _ProgressCircle({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final percentage = (value * 100).round();
    return Column(
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: value,
                strokeWidth: 6,
                backgroundColor: AppColors.primaryLight,
              ),
              Text('$percentage%'),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style:
          const TextStyle(fontSize: 12, color: AppColors.textLight),
        ),
      ],
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(Icons.star, color: AppColors.primary),
        SizedBox(height: 4),
        Text('Streak: 5 days',
            style: TextStyle(fontSize: 12, color: AppColors.textLight)),
      ],
    );
  }
}

// -------------------------------------------------------------
// AVAILABILITY DIALOG
// -------------------------------------------------------------

class _AvailabilityResult {
  final Set<String> days;
  final TimeOfDay start;
  final TimeOfDay end;

  _AvailabilityResult(this.days, this.start, this.end);
}

class AvailabilityDialog extends StatefulWidget {
  final Set<String> days;
  final TimeOfDay start;
  final TimeOfDay end;

  const AvailabilityDialog({
    super.key,
    required this.days,
    required this.start,
    required this.end,
  });

  @override
  State<AvailabilityDialog> createState() => _AvailabilityDialogState();
}

class _AvailabilityDialogState extends State<AvailabilityDialog> {
  late Set<String> _days;
  late TimeOfDay _start;
  late TimeOfDay _end;

  final _dayOptions = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
    super.initState();
    _days = Set.from(widget.days);
    _start = widget.start;
    _end = widget.end;
  }

  Future<void> _pickTime(bool isStart) async {
    final initial = isStart ? _start : _end;
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _start = picked;
        } else {
          _end = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set Availability'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 8,
            children: _dayOptions
                .map(
                  (d) => FilterChip(
                label: Text(d),
                selected: _days.contains(d),
                onSelected: (b) {
                  setState(() {
                    if (b) {
                      _days.add(d);
                    } else {
                      _days.remove(d);
                    }
                  });
                },
              ),
            )
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _pickTime(true),
                  child: Text('From ${_start.format(context)}'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _pickTime(false),
                  child: Text('To ${_end.format(context)}'),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(
              context,
              _AvailabilityResult(_days, _start, _end),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

// -------------------------------------------------------------
// COURSES LIST + DETAILS + ADD COURSE + UPLOAD FILES
// -------------------------------------------------------------

class CoursesPage extends StatelessWidget {
  final List<Course> courses;
  final ValueChanged<Course> onAddCourse;
  final ValueChanged<Course> onUpdateCourse;

  const CoursesPage({
    super.key,
    required this.courses,
    required this.onAddCourse,
    required this.onUpdateCourse,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                'Courses',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => _openAddCourse(context),
                icon: const Icon(Icons.add_box_outlined),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 72),
            children: [
              ...courses.map((c) => RoundedCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            c.semester,
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textLight),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () => _openCourseDetail(context, c),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('View'),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _openAddCourse(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Add Course'),
            ),
          ),
        ),
      ],
    );
  }

  void _openAddCourse(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddCourseScreen(
          onCreate: onAddCourse,
        ),
      ),
    );
  }

  void _openCourseDetail(BuildContext context, Course course) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CourseDetailScreen(
          course: course,
          onUpdate: onUpdateCourse,
        ),
      ),
    );
  }
}

// Add Course screen

class AddCourseScreen extends StatefulWidget {
  final ValueChanged<Course> onCreate;

  const AddCourseScreen({super.key, required this.onCreate});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _semesterController =
  TextEditingController(text: 'Fall Semester 2025');

  TimeOfDay _lectureStart = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _lectureEnd = const TimeOfDay(hour: 10, minute: 0);
  Set<String> _lectureDays = {'Mon', 'Wed', 'Fri'};

  final List<Exam> _exams = [];

  Future<void> _pickLectureTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _lectureStart : _lectureEnd,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _lectureStart = picked;
        } else {
          _lectureEnd = picked;
        }
      });
    }
  }

  Future<void> _addExam() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );
    if (date == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 11, minute: 0),
    );
    if (time == null) return;

    final dt =
    DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      _exams.add(
        Exam(
          label: 'Test – ${date.month}/${date.day}/${date.year}',
          dateTime: dt,
          location: 'TBD',
        ),
      );
    });
  }

  void _removeExam(int index) {
    setState(() {
      _exams.removeAt(index);
    });
  }

  void _createCourse() {
    if (_nameController.text.isEmpty || _codeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter course name & code.')),
      );
      return;
    }

    final course = Course(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '${_codeController.text} • ${_nameController.text}',
      code: _codeController.text,
      semester: _semesterController.text,
      exams: List.from(_exams),
    );
    widget.onCreate(course);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final dayOptions = const ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: RoundedCard(
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add Course',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Course Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Course Code',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Lecture Times'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.access_time),
                      label: Text(_lectureStart.format(context)),
                      onPressed: () => _pickLectureTime(true),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.arrow_forward),
                  ),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.access_time),
                      label: Text(_lectureEnd.format(context)),
                      onPressed: () => _pickLectureTime(false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: List.generate(dayOptions.length, (i) {
                  final label = dayOptions[i];
                  final full = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][i];
                  return FilterChip(
                    label: Text(label),
                    selected: _lectureDays.contains(full),
                    onSelected: (b) {
                      setState(() {
                        if (b) {
                          _lectureDays.add(full);
                        } else {
                          _lectureDays.remove(full);
                        }
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Midterm/Exam Dates'),
                  const Spacer(),
                  TextButton(
                    onPressed: _addExam,
                    child: const Text('Add Test'),
                  ),
                ],
              ),
              Column(
                children: [
                  for (int i = 0; i < _exams.length; i++)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(_exams[i].label),
                      subtitle: Text(
                        '${_exams[i].dateTime}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => _removeExam(i),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _createCourse,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding:
                        const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Create'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {}, // Upload files from here if desired
                      child: const Text('Upload Files'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Course detail screen

class CourseDetailScreen extends StatefulWidget {
  final Course course;
  final ValueChanged<Course> onUpdate;

  const CourseDetailScreen({
    super.key,
    required this.course,
    required this.onUpdate,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late Course _course;

  @override
  void initState() {
    super.initState();
    _course = widget.course.copyWith();
  }

  void _openUploadFiles() async {
    final result = await Navigator.of(context).push<List<String>>(
      MaterialPageRoute(
        builder: (_) => UploadFilesScreen(existingFiles: _course.files),
      ),
    );
    if (result != null) {
      setState(() {
        _course = _course.copyWith(files: result);
      });
      widget.onUpdate(_course);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_course.code),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _course.name.split('•').last.trim(),
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textLight,
              ),
            ),
          ),
          const SizedBox(height: 8),
          RoundedCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Upcoming Study Sessions',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                ..._course.sessions.map((s) => _SessionRow(session: s)),
              ],
            ),
          ),
          RoundedCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Files',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _course.files
                      .map(
                        (f) => Chip(
                      label: Text(f),
                      avatar: const Icon(Icons.description, size: 18),
                    ),
                  )
                      .toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _openUploadFiles,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Upload'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: _openUploadFiles,
                      child: const Text('Remove Files'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          RoundedCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tests & Study Plans',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                ..._course.exams.map(
                      (e) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(e.label),
                    subtitle: const Text('View/Edit Study Plan'),
                    trailing: OutlinedButton(
                      onPressed: () {},
                      child: const Text('View/Edit'),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Create Plan'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Upload files flow (simple)

class UploadFilesScreen extends StatefulWidget {
  final List<String> existingFiles;

  const UploadFilesScreen({super.key, required this.existingFiles});

  @override
  State<UploadFilesScreen> createState() => _UploadFilesScreenState();
}

class _UploadFilesScreenState extends State<UploadFilesScreen> {
  late List<String> _files;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _files = List.from(widget.existingFiles);
  }

  void _addFile() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    setState(() {
      _files.add(name);
      _controller.clear();
    });
  }

  void _removeFile(int index) {
    setState(() {
      _files.removeAt(index);
    });
  }

  void _confirm() {
    Navigator.pop(context, _files);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Files'),
      ),
      body: Column(
        children: [
          RoundedCard(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Upload Files',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Lecture01.pdf',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _addFile,
                      child: const Text('Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                    'Use this to simulate selecting files like in the mockups.'),
              ],
            ),
          ),
          Expanded(
            child: RoundedCard(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: _files.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(_files[i]),
                  leading: const Icon(Icons.insert_drive_file_outlined),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => _removeFile(i),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _confirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Confirm'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// PROGRESS PAGE (simplified, read-only)
// -------------------------------------------------------------

class ProgressPage extends StatelessWidget {
  final List<Course> courses;

  const ProgressPage({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                'Progress',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              ...courses.map(
                    (c) => RoundedCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Study Sessions 3/6   Topics 2/6',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textLight,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          _ProgressCircle(
                              label: 'Daily Progress', value: 0.3),
                          _ProgressCircle(
                              label: 'Weekly Progress', value: 0.7),
                          _StreakCard(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Placeholder tabs (Plan / Study)

class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        const Center(
          child: Text(
            'This section is a placeholder.\nMain flows are Dashboard and Courses.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textLight),
          ),
        ),
      ],
    );
  }
}
