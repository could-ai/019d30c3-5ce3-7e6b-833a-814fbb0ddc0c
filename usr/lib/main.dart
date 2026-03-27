import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/add_habit_screen.dart';
import 'screens/add_challenge_screen.dart';
import 'screens/daily_tracker_screen.dart';
import 'screens/preset_challenges_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/add_habit': (context) => const AddHabitScreen(),
        '/add_challenge': (context) => const AddChallengeScreen(),
        '/daily_tracker': (context) => const DailyTrackerScreen(),
        '/preset_challenges': (context) => const PresetChallengesScreen(),
      },
    );
  }
}