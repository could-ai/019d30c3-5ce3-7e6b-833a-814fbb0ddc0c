import 'package:flutter/material.dart';

class ProgressItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final VoidCallback onToggle;
  final Color color;
  final String icon;

  const ProgressItem({
    super.key,
    required this.title,
    required this.isCompleted,
    required this.onToggle,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(
            Icons.getIconData(icon),
            color: color,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            color: isCompleted ? Colors.grey : null,
          ),
        ),
        trailing: Checkbox(
          value: isCompleted,
          onChanged: (value) => onToggle(),
          activeColor: color,
        ),
      ),
    );
  }
}