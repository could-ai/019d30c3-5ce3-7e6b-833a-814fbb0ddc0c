import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';

class StreakDisplay extends StatelessWidget {
  const StreakDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HabitProvider>();

    // Calculate overall streak statistics
    int totalStreaks = 0;
    int longestStreak = 0;

    for (final habit in provider.habits) {
      final streak = provider.getStreak(habit.id);
      totalStreaks += streak;
      if (streak > longestStreak) longestStreak = streak;
    }

    for (final challenge in provider.challenges) {
      final streak = provider.getChallengeStreak(challenge.id);
      totalStreaks += streak;
      if (streak > longestStreak) longestStreak = streak;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_fire_department,
                  color: Colors.orange,
                  size: 32,
                ),
                const SizedBox(width: 8),
                Text(
                  'Total Streaks: $totalStreaks',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            if (longestStreak > 0) ...[
              const SizedBox(height: 8),
              Text(
                'Longest Streak: $longestStreak days',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }
}