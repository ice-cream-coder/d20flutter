class Roll {
  final int id;
  final String createdAt;
  final int die;
  final int side;
  final int rollGroupId;

  Roll({
    required this.id,
    required this.createdAt,
    required this.die,
    required this.side,
    required this.rollGroupId,
  });

  factory Roll.fromMap(Map<String, dynamic> json) => Roll(
        id: json['id'],
        createdAt: json['created_at'],
        die: json['die'],
        side: json['side'],
        rollGroupId: json['roll_group_id'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'die': die,
      'side': side,
      'roll_group_id': rollGroupId,
    };
  }
}
