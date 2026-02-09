import 'package:flutter/material.dart';
import 'package:student_app/core/app_theme.dart';

class AnalyticsDashboard extends StatelessWidget {
  final int totalLessons;
  final double attendanceRate;
  final int consistencyStreak;

  const AnalyticsDashboard({
    super.key,
    required this.totalLessons,
    required this.attendanceRate,
    required this.consistencyStreak,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130, // Fixed height for horizontal scrolling
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildCard(
            context,
            'مجموع الدروس',
            totalLessons.toString(),
            Icons.library_books,
            Colors.blueAccent,
          ),
          const SizedBox(width: 12),
          _buildCard(
            context,
            'نسبة الحضور',
            '${(attendanceRate * 100).toStringAsFixed(1)}%',
            Icons.pie_chart,
            attendanceRate >= 0.8 ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 12),
          _buildCard(
            context,
            'أيام المواظبة',
            '$consistencyStreak',
            Icons.local_fire_department,
            Colors.redAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String value, IconData icon, Color accentColor) {
    return Container(
      width: 140, // Square-ish cards
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.navyBlue,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: accentColor, size: 24),
              // We could add a mini graph here
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
