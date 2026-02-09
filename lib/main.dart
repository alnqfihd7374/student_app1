import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:student_app/core/app_theme.dart';
import 'package:student_app/core/hive_setup.dart';
import 'package:student_app/core/lesson_provider.dart';
import 'package:student_app/core/user_prefs.dart';
import 'package:student_app/screens/home_screen.dart';
import 'package:student_app/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await HiveSetup.init();
  
  // Check Onboarding Status
  final hasOnboarded = await UserPrefs.hasOnboarded();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LessonProvider()..init()),
      ],
      child: StudentApp(hasOnboarded: hasOnboarded),
    ),
  );
}

class StudentApp extends StatelessWidget {
  final bool hasOnboarded;

  const StudentApp({super.key, required this.hasOnboarded});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سجل طالب العلم',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Localization Setup
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''), // Arabic (Primary)
        Locale('en', ''), // English
      ],
      locale: const Locale('ar', ''), // Force Arabic for now
      home: hasOnboarded ? const HomeScreen() : const OnboardingScreen(),
    );
  }
}
