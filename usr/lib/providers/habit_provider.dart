import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/habit.dart';
import '../models/challenge.dart';
import '../models/progress_entry.dart';

class HabitProvider with ChangeNotifier {
  List<Habit> _habits = [];
  List<Challenge> _challenges = [];
  List<ProgressEntry> _progressEntries = [];

  List<Habit> get habits => _habits;
  List<Challenge> get challenges => _challenges;
  List<ProgressEntry> get progressEntries => _progressEntries;

  HabitProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final habitsJson = prefs.getString('habits');
    final challengesJson = prefs.getString('challenges');
    final progressJson = prefs.getString('progress');

    if (habitsJson != null) {
      final habitsList = jsonDecode(habitsJson) as List;
      _habits = habitsList.map((h) => Habit.fromJson(h)).toList();
    }

    if (challengesJson != null) {
      final challengesList = jsonDecode(challengesJson) as List;
      _challenges = challengesList.map((c) => Challenge.fromJson(c)).toList();
    }

    if (progressJson != null) {
      final progressList = jsonDecode(progressJson) as List;
      _progressEntries = progressList.map((p) => ProgressEntry.fromJson(p)).toList();
    }

    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('habits', jsonEncode(_habits.map((h) => h.toJson()).toList()));
    await prefs.setString('challenges', jsonEncode(_challenges.map((c) => c.toJson()).toList()));
    await prefs.setString('progress', jsonEncode(_progressEntries.map((p) => p.toJson()).toList()));
  }

  void addHabit(Habit habit) {
    _habits.add(habit);
    _saveData();
    notifyListeners();
  }

  void addChallenge(Challenge challenge) {
    _challenges.add(challenge);
    _saveData();
    notifyListeners();
  }

  void toggleHabitCompletion(String habitId, DateTime date) {
    final existingEntry = _progressEntries.firstWhere(
      (entry) => entry.habitId == habitId && _isSameDay(entry.date, date),
      orElse: () => ProgressEntry(habitId: habitId, date: date, isCompleted: false),
    );

    if (_progressEntries.contains(existingEntry)) {
      existingEntry.isCompleted = !existingEntry.isCompleted;
    } else {
      _progressEntries.add(ProgressEntry(habitId: habitId, date: date, isCompleted: true));
    }

    _saveData();
    notifyListeners();
  }

  void markChallengeTaskCompleted(String challengeId, String taskId, DateTime date) {
    final existingEntry = _progressEntries.firstWhere(
      (entry) => entry.challengeId == challengeId && entry.taskId == taskId && _isSameDay(entry.date, date),
      orElse: () => ProgressEntry(challengeId: challengeId, taskId: taskId, date: date, isCompleted: false),
    );

    if (_progressEntries.contains(existingEntry)) {
      existingEntry.isCompleted = !existingEntry.isCompleted;
    } else {
      _progressEntries.add(ProgressEntry(challengeId: challengeId, taskId: taskId, date: date, isCompleted: true));
    }

    _saveData();
    notifyListeners();
  }

  int getStreak(String habitId) {
    final habitEntries = _progressEntries.where((entry) => entry.habitId == habitId && entry.isCompleted).toList();
    if (habitEntries.isEmpty) return 0;

    habitEntries.sort((a, b) => b.date.compareTo(a.date));
    int streak = 0;
    DateTime currentDate = DateTime.now();

    for (final entry in habitEntries) {
      if (_isSameDay(entry.date, currentDate) || _isSameDay(entry.date, currentDate.subtract(Duration(days: streak)))) {
        streak++;
        currentDate = currentDate.subtract(Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  int getChallengeStreak(String challengeId) {
    final challenge = _challenges.firstWhere((c) => c.id == challengeId);
    final challengeEntries = _progressEntries.where((entry) => entry.challengeId == challengeId && entry.isCompleted).toList();
    if (challengeEntries.isEmpty) return 0;

    Map<DateTime, bool> dailyCompletion = {};
    for (final task in challenge.tasks) {
      final taskEntries = challengeEntries.where((entry) => entry.taskId == task.id);
      for (final entry in taskEntries) {
        dailyCompletion[DateTime(entry.date.year, entry.date.month, entry.date.day)] = true;
      }
    }

    final sortedDates = dailyCompletion.keys.toList()..sort((a, b) => b.compareTo(a));
    int streak = 0;
    DateTime currentDate = DateTime.now();

    for (final date in sortedDates) {
      if (_isSameDay(date, currentDate) || _isSameDay(date, currentDate.subtract(Duration(days: streak)))) {
        streak++;
        currentDate = currentDate.subtract(Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  void deleteHabit(String habitId) {
    _habits.removeWhere((h) => h.id == habitId);
    _progressEntries.removeWhere((p) => p.habitId == habitId);
    _saveData();
    notifyListeners();
  }

  void deleteChallenge(String challengeId) {
    _challenges.removeWhere((c) => c.id == challengeId);
    _progressEntries.removeWhere((p) => p.challengeId == challengeId);
    _saveData();
    notifyListeners();
  }
}