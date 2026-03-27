import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';

class ChallengeCard extends StatelessWidget {
  final dynamic challenge;

  const ChallengeCard({super.key, required this.challenge});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HabitProvider>();
    final streak = provider.getChallengeStreak(challenge.id);

    return Dismissible(
      key: Key(challenge.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        provider.deleteChallenge(challenge.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${challenge.name} deleted')),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: challenge.color.withOpacity(0.2),
            child: Icon(
              Icons.flag,
              color: challenge.color,
            ),
          ),
          title: Text(challenge.name),
          subtitle: Text('${challenge.tasks.length} daily tasks'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_fire_department,
                color: Colors.orange,
              ),
              Text(
                '$streak',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          children: challenge.tasks.map<Widget>((task) => ListTile(
            title: Text(task.name),
            dense: true,
          )).toList(),
        ),
      ),
    );
  }
}