import 'package:uuid/uuid.dart';

class Roll {
  final String id;
  final int die;
  final int side;
  final String rollGroupId;
  final DateTime createdAt;

  Roll({
    required this.die,
    required this.side,
    required this.rollGroupId,
  })  : id = const Uuid().v4(),
        createdAt = DateTime.now();

  Roll._fromMap({
    required this.id,
    required this.die,
    required this.side,
    required this.rollGroupId,
    required this.createdAt,
  });

  factory Roll.fromMap(Map<String, dynamic> json) => Roll._fromMap(
        id: json['id'],
        die: json['die'],
        side: json['side'],
        rollGroupId: json['roll_group_id'],
        createdAt: json['created_at'],
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
