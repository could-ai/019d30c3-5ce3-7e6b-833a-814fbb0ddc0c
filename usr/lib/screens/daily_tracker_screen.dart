import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/habit_provider.dart';
import '../widgets/progress_item.dart';

class DailyTrackerScreen extends StatelessWidget {
  const DailyTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final formattedDate = DateFormat('EEEE, MMMM d, y').format(today);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _showDatePicker(context),
          ),
        ],
      ),
      body: Consumer<HabitProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                formattedDate,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // ... existing code ...
            ],
          );
        },
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        // Navigate to tracker for selected date
        // This would require modifying the screen to accept a date parameter
      }
    });
  }

  // ... existing code ...
}