import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPicker({
    super.key,
    required this.selectedColor,
    required this.onColorChanged,
  });

  final List<Color> _colors = const [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Color',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _colors.map((color) {
            return GestureDetector(
              onTap: () => onColorChanged(color),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: selectedColor == color
                      ? Border.all(color: Colors.black, width: 3)
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}