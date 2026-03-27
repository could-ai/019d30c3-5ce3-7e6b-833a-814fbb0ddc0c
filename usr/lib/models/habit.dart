class Habit {
  final String id;
  final String name;
  final String description;
  final String icon;
  final Color color;

  Habit({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'color': color.value,
    };
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      color: Color(json['color']),
    );
  }
}