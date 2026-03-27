import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../models/habit.dart';
import '../widgets/color_picker.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedIcon = 'fitness_center';
  Color _selectedColor = Colors.blue;

  final List<String> _icons = [
    'fitness_center',
    'local_drink',
    'restaurant',
    'book',
    'bedtime',
    'self_improvement',
    'nature',
    'music_note',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Habit'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Habit Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a habit name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const Text(
              'Choose Icon',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _icons.map((icon) {
                return ChoiceChip(
                  selected: _selectedIcon == icon,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedIcon = icon);
                    }
                  },
                  label: Icon(Icons.getIconData(icon)),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ColorPicker(
              selectedColor: _selectedColor,
              onColorChanged: (color) => setState(() => _selectedColor = color),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveHabit,
              child: const Text('Save Habit'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveHabit() {
    if (_formKey.currentState!.validate()) {
      final habit = Habit(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        icon: _selectedIcon,
        color: _selectedColor,
      );

      context.read<HabitProvider>().addHabit(habit);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}