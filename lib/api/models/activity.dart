import 'dart:ffi';
import 'dart:developer';

class Activity {
  final int id;

  final String? name;

  final String? description;

  final int? fileId;

  final Set<String> linkedTo;

  final int userId;

  final DateTime? createdAt;

  final DateTime? startedAt;

  final DateTime? updatedAt;

  const Activity({
    required this.id,
    required this.name,
    required this.description,
    required this.fileId,
    required this.linkedTo,
    required this.userId,
    required this.createdAt,
    required this.startedAt,
    required this.updatedAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as int,
      name: json['name'] as String?,
      description: json['description'] as String?,
      fileId: json['file_id'] as int?,
      linkedTo: Set<String>.from(json['linked_to'] as List),
      userId: json['user_id'] as int,
      startedAt: json['started_at'] != null
          ? DateTime.parse(json['started_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}
