import 'package:flutter/material.dart';

import 'auth.dart';
import 'dashboard.dart';
import 'courses.dart';
import 'plan.dart';
import 'study.dart';
import 'progress.dart';
import 'models.dart';

void main() {
  runApp(const StudyBuddyApp());
}

class StudyBuddyApp extends StatefulWidget {
  const StudyBuddyApp({super.key});

  @override
  State<StudyBuddyApp> createState() => _StudyBuddyAppState();
}

class _StudyBuddyAppState extends State<StudyBuddyApp> {
  bool _loggedIn = false;

  void _handleLoggedIn() {
    setState(() {
      _loggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Buddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        useMaterial3: false,
      ),
      // No weird keys, just a normal root
      home: _loggedIn
          ? const MainShell()
          : AuthScreen(onAuthenticated: _handleLoggedIn),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  Availability? _availability;
  late List<Course> _courses;

  @override
  void initState() {
    super.initState();
    _courses = [
      Course(
        id: '1',
        name: 'CSCI 4620U · Human-Computer Interaction',
        code: 'CSCI 4620U',
        semester: 'Fall Semester 2025',
        files: [
          StudyFile(name: 'Lecture01.pdf', topic: 'Design Lifecycle'),
          StudyFile(name: 'Lecture02.pdf', topic: 'Design Lifecycle'),
        ],
      ),
      Course(
        id: '2',
        name: 'CSCI 3310U · Systems Programming',
        code: 'CSCI 3310U',
        semester: 'Fall Semester 2025',
      ),
    ];
  }

  void _setAvailability(Availability avail) {
    setState(() {
      _availability = avail;
    });
  }

  void _addCourse(Course course) {
    setState(() {
      _courses.add(course);
    });
  }

  void _updateCourse(Course updated) {
    final index = _courses.indexWhere((c) => c.id == updated.id);
    if (index != -1) {
      setState(() {
        _courses[index] = updated;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    switch (_currentIndex) {
      case 0:
        body = DashboardPage(
          availability: _availability,
          onEditAvailability: () async {
            final result = await Navigator.of(context).push<Availability>(
              MaterialPageRoute(
                builder: (_) =>
                    AvailabilityPage(initialAvailability: _availability),
              ),
            );
            if (result != null) {
              _setAvailability(result);
            }
          },
          onStartStudy: () {
            setState(() => _currentIndex = 3);
          },
        );
        break;

      case 1:
        body = CoursesPage(
          courses: _courses,
          onAddCourse: _addCourse,
          onUpdateCourse: _updateCourse,
        );
        break;

      case 2:
        body = const PlanPage();
        break;

      case 3:
        body = const StudyPage();
        break;

      case 4:
        body = ProgressPage(courses: _courses);
        break;

      default:
        body = const SizedBox.shrink();
    }

    return Scaffold(
      body: SafeArea(child: body),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
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
