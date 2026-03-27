import 'package:flutter/material.dart';
import 'screens/preset_challenges_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddMenu(context),
          ),
        ],
      ),
      // ... existing body code ...
    );
  }

  void _showAddMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add_circle),
              title: const Text('Add Habit'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/add_habit');
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Add Challenge'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/add_challenge');
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_add),
              title: const Text('Preset Challenges'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PresetChallengesScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}