import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_app/core/app_theme.dart';
import 'package:student_app/core/user_prefs.dart';
import 'package:student_app/screens/settings_screen.dart';

class NavyHeader extends StatefulWidget {
  const NavyHeader({super.key});

  @override
  State<NavyHeader> createState() => _NavyHeaderState();
}

class _NavyHeaderState extends State<NavyHeader> {
  String _kunya = '';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await UserPrefs.getUser();
    if (mounted) {
      setState(() {
        _kunya = user['kunya'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    // Simple Arabic date formatting
    // Note: For true Hijri date, we would need 'hijri' package.
    // For now, using standard date with Arabic locale.
    final dateStr = DateFormat('EEEE, d MMMM yyyy', 'ar').format(now);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
      decoration: const BoxDecoration(
        color: AppColors.navyBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مرحباً بك يا $_kunya',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.pureWhite,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: AppColors.pureWhite),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            dateStr,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.pureWhite.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
