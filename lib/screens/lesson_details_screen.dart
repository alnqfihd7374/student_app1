import 'package:flutter/material.dart';
import 'package:student_app/core/app_theme.dart';
import 'package:student_app/models/lesson.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/core/hive_setup.dart'; // Import to ensure hive is available

class LessonDetailsScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonDetailsScreen({super.key, required this.lesson});

  @override
  State<LessonDetailsScreen> createState() => _LessonDetailsScreenState();
}

class _LessonDetailsScreenState extends State<LessonDetailsScreen> {
  late TextEditingController _notesController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: widget.lesson.notes ?? '');
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _saveNotes() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedLesson = widget.lesson.copyWith(
        notes: _notesController.text,
      );
      
      // Update in Hive box using the original object's key
      final box = Hive.box<Lesson>(HiveSetup.lessonsBoxName);
      box.put(widget.lesson.key, updatedLesson); // Use persistent key

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حفظ الفوائد بنجاح')),
      );
    }
  }

  void _deleteLesson() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف الدرس'),
        content: const Text('هل أنت متأكد من حذف هذا الدرس وجميع فوائده؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              widget.lesson.delete();
              Navigator.pop(ctx); // Close dialog
              Navigator.pop(context); // Close details screen
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'attended':
        return AppColors.attendedGreen;
      case 'missed':
        return AppColors.missedRed;
      case 'excused':
        return Colors.orange;
      case 'postponed':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'attended':
        return 'حضر';
      case 'missed':
        return 'غاب';
      case 'excused':
        return 'معذور';
      case 'postponed':
        return 'مؤجل';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('EEEE, d MMMM yyyy', 'ar').format(widget.lesson.date);

    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        title: Text(widget.lesson.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteLesson,
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNotes,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Meta Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.lightGray.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.lightGray),
                ),
                child: Column(
                  children: [
                    _buildMetaRow(Icons.person, 'الشيخ', widget.lesson.teacher),
                    const Divider(),
                    _buildMetaRow(Icons.calendar_today, 'التاريخ', dateStr),
                    const Divider(),
                    _buildMetaRow(
                      Icons.check_circle, 
                      'الحالة', 
                      _getStatusText(widget.lesson.status),
                      color: _getStatusColor(widget.lesson.status),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Notes Section
              Text(
                'الفوائد العلمية والشوارد',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 20,
                  color: AppColors.navyBlue,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF9E7), // Light yellow paper feel
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.goldAccent.withValues(alpha: 0.3)),
                ),
                child: TextFormField(
                  controller: _notesController,
                  maxLines: 15, // Large text area
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'سجل فوائدك هنا...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(24),
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetaRow(IconData icon, String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color ?? AppColors.navyBlue, size: 20),
          const SizedBox(width: 12),
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: color ?? AppColors.navyBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
