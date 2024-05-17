class RollGroup {
  final String id;
  final DateTime createdAt;

  RollGroup({required this.id}) : createdAt = DateTime.now();

  RollGroup._fromMap({required this.id, required this.createdAt});

  factory RollGroup.fromMap(Map<String, dynamic> json) => RollGroup._fromMap(
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
