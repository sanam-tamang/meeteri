import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String title;
  String description;
  bool isCompleted;
  Timestamp timestamp;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.timestamp,
  });

  factory Task.fromJson(Map<String, dynamic> json, String id) {
    return Task(
      id: id,
      title: json['title']??"",
      description: json['description']??"",
      isCompleted: json['isCompleted'] ?? false,
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'timestamp': timestamp,
    };
  }
}
