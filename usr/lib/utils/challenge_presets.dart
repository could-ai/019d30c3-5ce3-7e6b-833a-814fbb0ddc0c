import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../models/challenge.dart';
import '../models/challenge_task.dart';

void add75HardChallenge(BuildContext context) {
  final provider = context.read<HabitProvider>();

  final tasks = [
    ChallengeTask(
      id: 'workout1',
      name: 'Two 45-minute workouts (one outside)',
      description: 'Complete two 45-minute workout sessions, with at least one outdoors',
    ),
    ChallengeTask(
      id: 'diet',
      name: 'Follow a diet',
      description: 'Stick to your chosen diet with no cheat meals',
    ),
    ChallengeTask(
      id: 'water',
      name: 'Drink a gallon of water',
      description: 'Consume one gallon (3.8 liters) of water throughout the day',
    ),
    ChallengeTask(
      id: 'reading',
      name: 'Read 10 pages of nonfiction',
      description: 'Read at least 10 pages of a nonfiction book',
    ),
    ChallengeTask(
      id: 'photo',
      name: 'Take progress picture',
      description: 'Take a daily progress photo',
    ),
  ];

  final challenge = Challenge(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    name: '75 Hard',
    description: 'The original 75 Hard challenge: 75 days of strict discipline',
    tasks: tasks,
    color: Colors.red,
  );

  provider.addChallenge(challenge);
}