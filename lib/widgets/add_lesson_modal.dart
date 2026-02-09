import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/core/app_theme.dart';
import 'package:student_app/models/lesson.dart';
import 'package:student_app/core/lesson_provider.dart';
import 'package:uuid/uuid.dart';

class AddLessonModal extends StatefulWidget {
  const AddLessonModal({super.key});

  @override
  State<AddLessonModal> createState() => _AddLessonModalState();
}

class _AddLessonModalState extends State<AddLessonModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _teacherController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _status = 'attended'; // Default

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'إضافة درس جديد',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'اسم المتن / الكتاب'),
              validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _teacherController,
              decoration: const InputDecoration(labelText: 'اسم الشيخ'),
              validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
            ),
            const SizedBox(height: 16),
            
            // Date Picker Row
            Row(
              children: [
                Expanded(
                  child: Text(
                    'التاريخ: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      setState(() => _selectedDate = picked);
                    }
                  },
                  child: const Text('تغيير'),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Status Dropdown
            DropdownButtonFormField<String>(
              value: _status,
              decoration: const InputDecoration(labelText: 'حالة الحضور'),
              items: const [
                DropdownMenuItem(value: 'attended', child: Text('حضر')),
                DropdownMenuItem(value: 'missed', child: Text('غاب')),
                DropdownMenuItem(value: 'excused', child: Text('معذور')),
                DropdownMenuItem(value: 'postponed', child: Text('مؤجل')),
              ],
              onChanged: (v) => setState(() => _status = v!),
            ),
            
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('حفظ الدرس'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final newLesson = Lesson(
        id: const Uuid().v4(),
        title: _titleController.text,
        teacher: _teacherController.text,
        date: _selectedDate,
        status: _status,
      );

      context.read<LessonProvider>().addLesson(newLesson);
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تمت إضافة الدرس بنجاح')),
      );
    }
  }
}
