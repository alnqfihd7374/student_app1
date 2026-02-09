import 'package:flutter/material.dart';
import 'package:student_app/core/app_theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:hive/hive.dart';
import 'package:student_app/core/hive_setup.dart';
import 'dart:io';
import 'dart:convert';
import 'package:student_app/models/lesson.dart';
import 'package:file_picker/file_picker.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _exportData(BuildContext context) async {
    try {
      final box = Hive.box<Lesson>(HiveSetup.lessonsBoxName);
      final List<Map<String, dynamic>> data = box.values.map((l) => {
        'id': l.id,
        'title': l.title,
        'teacher': l.teacher,
        'date': l.date.toIso8601String(),
        'status': l.status,
        'notes': l.notes,
      }).toList();

      final jsonString = jsonEncode(data);
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/backup_student_app.json');
      await file.writeAsString(jsonString);

      await Share.shareXFiles([XFile(file.path)], text: 'نسخة احتياطية - سجل طالب العلم');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل التصدير: $e')),
        );
      }
    }
  }

  Future<void> _importData(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        final file = File(result.files.single.path!);
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(jsonString);
        
        final box = Hive.box<Lesson>(HiveSetup.lessonsBoxName);
        await box.clear(); // Caution: Clears current data
        
        for (var item in jsonList) {
          final lesson = Lesson(
            id: item['id'],
            title: item['title'],
            teacher: item['teacher'],
            date: DateTime.parse(item['date']),
            status: item['status'],
            notes: item['notes'],
          );
          await box.add(lesson);
        }
        
        if (context.mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم استعادة البيانات بنجاح. يرجى إعادة تشغيل التطبيق.')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل الاستيراد: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        title: const Text('الإعدادات'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          _buildSectionHeader(context, 'البيانات والنسخ الاحتياطي'),
          ListTile(
            leading: const Icon(Icons.download, color: AppColors.navyBlue),
            title: const Text('تصدير البيانات (Backup)'),
            subtitle: const Text('حفظ نسخة من جميع دروسك وفوائدك'),
            onTap: () => _exportData(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.upload, color: AppColors.navyBlue),
            title: const Text('استيراد البيانات (Restore)'),
            subtitle: const Text('استعادة نسخة سابقة'),
            onTap: () => _importData(context),
          ),
          
          const SizedBox(height: 20),
          _buildSectionHeader(context, 'المظهر'),
          SwitchListTile(
            value: false, // TODO: Implement Dark Mode State
            onChanged: (val) {
              if (context.mounted) {
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('الوضع الليلي قادم قريباً!')),
                );
              }
            },
            title: const Text('الوضع الليلي'),
            secondary: const Icon(Icons.dark_mode, color: AppColors.navyBlue),
          ),
          
          const SizedBox(height: 20),
          _buildSectionHeader(context, 'حول التطبيق'),
          ListTile(
            leading: const Icon(Icons.info, color: AppColors.navyBlue),
            title: const Text('سجل طالب العلم'),
            subtitle: const Text('الإصدار 1.0.0'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.navyBlue.withValues(alpha: 0.7),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
