import 'dart:ffi';

class User {
  final int id;

  final String name;

  final String email;

  const User({
    required this.id,
    required this.name,
    required this.email
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

}