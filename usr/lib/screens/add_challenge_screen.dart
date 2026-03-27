import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../models/challenge.dart';
import '../widgets/color_picker.dart';

class AddChallengeScreen extends StatefulWidget {
  const AddChallengeScreen({super.key});

  @override
  State<AddChallengeScreen> createState() => _AddChallengeScreenState();
}

class _AddChallengeScreenState extends State<AddChallengeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<TextEditingController> _taskControllers = [];
  Color _selectedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Challenge'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addTask,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Challenge Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a challenge name';
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
            ColorPicker(
              selectedColor: _selectedColor,
              onColorChanged: (color) => setState(() => _selectedColor = color),
            ),
            const SizedBox(height: 16),
            const Text(
              'Daily Tasks',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._buildTaskFields(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveChallenge,
              child: const Text('Save Challenge'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTaskFields() {
    return List.generate(_taskControllers.length, (index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _taskControllers[index],
                decoration: InputDecoration(
                  labelText: 'Task ${index + 1}',
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task';
                  }
                  return null;
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => _removeTask(index),
            ),
          ],
        ),
      );
    });
  }

  void _addTask() {
    setState(() {
      _taskControllers.add(TextEditingController());
    });
  }

  void _removeTask(int index) {
    setState(() {
      _taskControllers[index].dispose();
      _taskControllers.removeAt(index);
    });
  }

  void _saveChallenge() {
    if (_formKey.currentState!.validate() && _taskControllers.isNotEmpty) {
      final tasks = _taskControllers.map((controller) => ChallengeTask(
        id: DateTime.now().millisecondsSinceEpoch.toString() + controller.text.hashCode.toString(),
        name: controller.text,
        description: '',
      )).toList();

      final challenge = Challenge(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        tasks: tasks,
        color: _selectedColor,
      );

      context.read<HabitProvider>().addChallenge(challenge);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    for (final controller in _taskControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}