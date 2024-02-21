class RollGroup {
  final int id;
  final String createdAt;

  RollGroup({required this.id, required this.createdAt});

  factory RollGroup.fromMap(Map<String, dynamic> json) => RollGroup(
        id: json['id'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
    };
  }
}
