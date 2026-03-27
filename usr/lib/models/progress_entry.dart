class ProgressEntry {
  final String? habitId;
  final String? challengeId;
  final String? taskId;
  final DateTime date;
  bool isCompleted;

  ProgressEntry({
    this.habitId,
    this.challengeId,
    this.taskId,
    required this.date,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'habitId': habitId,
      'challengeId': challengeId,
      'taskId': taskId,
      'date': date.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory ProgressEntry.fromJson(Map<String, dynamic> json) {
    return ProgressEntry(
      habitId: json['habitId'],
      challengeId: json['challengeId'],
      taskId: json['taskId'],
      date: DateTime.parse(json['date']),
      isCompleted: json['isCompleted'],
    );
  }
}