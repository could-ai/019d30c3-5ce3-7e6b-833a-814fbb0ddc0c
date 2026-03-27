import 'package:flutter/material.dart';

class Challenge {
  final String id;
  final String name;
  final String description;
  final List<ChallengeTask> tasks;
  final Color color;

  Challenge({
    required this.id,
    required this.name,
    required this.description,
    required this.tasks,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'tasks': tasks.map((t) => t.toJson()).toList(),
      'color': color.value,
    };
  }

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      tasks: (json['tasks'] as List).map((t) => ChallengeTask.fromJson(t)).toList(),
      color: Color(json['color']),
    );
  }
}

class ChallengeTask {
  final String id;
  final String name;
  final String description;

  ChallengeTask({
    required this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory ChallengeTask.fromJson(Map<String, dynamic> json) {
    return ChallengeTask(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}