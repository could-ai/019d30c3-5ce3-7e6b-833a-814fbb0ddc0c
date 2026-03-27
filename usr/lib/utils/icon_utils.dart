import 'package:flutter/material.dart';

extension IconExtension on Icons {
  static IconData getIconData(String iconName) {
    switch (iconName) {
      case 'fitness_center':
        return Icons.fitness_center;
      case 'local_drink':
        return Icons.local_drink;
      case 'restaurant':
        return Icons.restaurant;
      case 'book':
        return Icons.book;
      case 'bedtime':
        return Icons.bedtime;
      case 'self_improvement':
        return Icons.self_improvement;
      case 'nature':
        return Icons.nature;
      case 'music_note':
        return Icons.music_note;
      case 'check_circle':
        return Icons.check_circle;
      default:
        return Icons.star;
    }
  }
}