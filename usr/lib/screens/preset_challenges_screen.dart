import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../utils/challenge_presets.dart';

class PresetChallengesScreen extends StatelessWidget {
  const PresetChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preset Challenges'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.flag, color: Colors.red),
            title: const Text('75 Hard Challenge'),
            subtitle: const Text('75 days of mental toughness and discipline'),
            onTap: () {
              add75HardChallenge(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('75 Hard Challenge added!')),
              );
            },
          ),
          // Add more preset challenges here
        ],
      ),
    );
  }
}