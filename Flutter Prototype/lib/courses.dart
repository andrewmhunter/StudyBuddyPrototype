import 'package:flutter/material.dart';
import 'models.dart';

class CoursesPage extends StatelessWidget {
  final List<Course> courses;
  final ValueChanged<Course> onUpdateCourse;
  final ValueChanged<Course> onAddCourse;

  const CoursesPage({
    super.key,
    required this.courses,
    required this.onUpdateCourse,
    required this.onAddCourse,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Courses',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        title: Text(
                          course.name,
                          style: const TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          course.semester,
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () async {
                            final updated = await Navigator.of(context)
                                .push<Course>(MaterialPageRoute(
                              builder: (_) => CourseDetailPage(course: course),
                            ));
                            if (updated != null) {
                              onUpdateCourse(updated);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('View'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    final newCourse =
                    await Navigator.of(context).push<Course>(
                      MaterialPageRoute(
                          builder: (_) => const AddCoursePage()),
                    );
                    if (newCourse != null) {
                      onAddCourse(newCourse);
                    }
                  },
                  child: const Text('Add Course'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Add Course Page

class AddCoursePage extends StatefulWidget {
  const AddCoursePage({super.key});

  @override
  State<AddCoursePage> createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);
  List<bool> _selectedDays = List<bool>.filled(5, true); // Mon–Fri
  final List<DateTime> _tests = [];

  Future<void> _pickTime(bool isStart) async {
    final result = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
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

  Future<void> _addTest() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 7)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (time == null) return;

    final dt =
    DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      _tests.add(dt);
    });
  }

  void _create() {
    if (_nameController.text.trim().isEmpty ||
        _codeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter course name and code')),
      );
      return;
    }
    final course = Course(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '${_codeController.text.trim()} · ${_nameController.text.trim()}',
      code: _codeController.text.trim(),
      semester: 'Fall Semester 2025',
    );
    Navigator.of(context).pop(course);
  }

  @override
  Widget build(BuildContext context) {
    final labels = ['M', 'T', 'W', 'T', 'F'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Course Name'),
                    const SizedBox(height: 8),
                    _roundedPlainField(_nameController, 'Course Name'),
                    const SizedBox(height: 12),
                    const Text('Course Code'),
                    const SizedBox(height: 8),
                    _roundedPlainField(_codeController, 'Course Code'),
                    const SizedBox(height: 16),
                    const Text('Lecture Times'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _timeButton(
                            label: _startTime.format(context),
                            onTap: () => _pickTime(true),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('→'),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _timeButton(
                            label: _endTime.format(context),
                            onTap: () => _pickTime(false),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ToggleButtons(
                      isSelected: _selectedDays,
                      onPressed: (i) {
                        setState(() {
                          _selectedDays[i] = !_selectedDays[i];
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      children: labels
                          .map((d) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: Text(d),
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Midterm/Exam Dates'),
                        TextButton(
                          onPressed: _addTest,
                          child: const Text('Add Test'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: _tests
                          .asMap()
                          .entries
                          .map(
                            (entry) => ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.event),
                          title:
                          Text('${entry.value.toLocal()}'.split('.')[0]),
                          trailing: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _tests.removeAt(entry.key);
                              });
                            },
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Upload Files'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: ElevatedButton(
                        onPressed: _create,
                        child: const Text('Create'),
                      ),
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

  Widget _timeButton({required String label, required VoidCallback onTap}) {
    return OutlinedButton(
      onPressed: onTap,
      child: Text(label),
    );
  }

  Widget _roundedPlainField(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: controller,
        decoration:
        InputDecoration(border: InputBorder.none, hintText: hint),
      ),
    );
  }
}

/// Course Detail Page

class CourseDetailPage extends StatefulWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late Course _course;

  @override
  void initState() {
    super.initState();
    _course = Course(
      id: widget.course.id,
      name: widget.course.name,
      code: widget.course.code,
      semester: widget.course.semester,
      files: List<StudyFile>.from(widget.course.files),
    );
  }

  Future<void> _uploadFiles() async {
    final updatedFiles = await Navigator.of(context).push<List<StudyFile>>(
      MaterialPageRoute(
        builder: (_) => UploadFilesPage(initialFiles: _course.files),
      ),
    );
    if (updatedFiles != null) {
      setState(() {
        _course.files = updatedFiles;
      });
    }
  }

  void _editFile(StudyFile file) async {
    final nameController = TextEditingController(text: file.name);
    final topicController = TextEditingController(text: file.topic);

    final result = await showDialog<StudyFile>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit File'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration:
              const InputDecoration(labelText: 'File Name'),
            ),
            TextField(
              controller: topicController,
              decoration:
              const InputDecoration(labelText: 'Topic / Section'),
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
                StudyFile(
                  name: nameController.text.trim(),
                  topic: topicController.text.trim(),
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() {
        final idx = _course.files.indexOf(file);
        if (idx != -1) _course.files[idx] = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_course.code),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              _course.name,
              style:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Files',
                style:
                TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: _course.files.isEmpty
                    ? const Center(
                    child: Text(
                      'No files uploaded yet.',
                      style: TextStyle(color: Colors.grey),
                    ))
                    : ListView.builder(
                  itemCount: _course.files.length,
                  itemBuilder: (context, index) {
                    final file = _course.files[index];
                    return ListTile(
                      leading: const Icon(Icons.picture_as_pdf),
                      title: Text(file.name),
                      subtitle: Text(file.topic),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editFile(file),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 46,
                    child: OutlinedButton(
                      onPressed: _uploadFiles,
                      child: const Text('Upload Files'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(_course);
                      },
                      child: const Text('Done'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Upload Files Page (simulated)

class UploadFilesPage extends StatefulWidget {
  final List<StudyFile> initialFiles;

  const UploadFilesPage({super.key, required this.initialFiles});

  @override
  State<UploadFilesPage> createState() => _UploadFilesPageState();
}

class _UploadFilesPageState extends State<UploadFilesPage> {
  late List<StudyFile> _files;

  final _newNameController = TextEditingController();
  final _newTopicController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _files = List<StudyFile>.from(widget.initialFiles);
  }

  void _addFile() {
    final name = _newNameController.text.trim();
    if (name.isEmpty) return;
    final topic = _newTopicController.text.trim();
    setState(() {
      _files.add(StudyFile(name: name, topic: topic));
      _newNameController.clear();
      _newTopicController.clear();
    });
  }

  void _upload() {
    Navigator.of(context).pop(_files);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Files'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'These are simulated uploads – no real files needed.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _files.length,
                itemBuilder: (context, index) {
                  final file = _files[index];
                  return ListTile(
                    leading: const Icon(Icons.picture_as_pdf),
                    title: Text(file.name),
                    subtitle: Text(file.topic),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _files.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _newNameController,
                    decoration: const InputDecoration(
                      labelText: 'File name (e.g., Lecture01.pdf)',
                    ),
                  ),
                  TextField(
                    controller: _newTopicController,
                    decoration: const InputDecoration(
                      labelText: 'Topic / Section (optional)',
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _addFile,
                      child: const Text('Add File'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _upload,
                child: const Text('Upload'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
