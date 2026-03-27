import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';

class HabitCard extends StatelessWidget {
  final dynamic habit;

  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HabitProvider>();
    final streak = provider.getStreak(habit.id);

    return Dismissible(
      key: Key(habit.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        provider.deleteHabit(habit.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${habit.name} deleted')),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: habit.color.withOpacity(0.2),
            child: Icon(
              Icons.getIconData(habit.icon),
              color: habit.color,
            ),
          ),
          title: Text(habit.name),
          subtitle: Text(habit.description),
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
          onTap: () {
            // Could navigate to detail view
          },
        ),
      ),
    );
  }
}