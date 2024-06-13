// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String username;
  final String email;
  final String gender;
  final String userType;
  final String? avatar;
  final String dateOfBirth;
  const User({
    required this.userId,
    required this.username,
    required this.email,
    required this.gender,
    required this.userType,
    this.avatar,
    required this.dateOfBirth,
  });

  User copyWith({
    String? userId,
    String? username,
    String? email,
    String? gender,
    String? userType,
    String? avatar,
    String? dateOfBirth,
  }) {
    return User(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      userType: userType ?? this.userType,
      avatar: avatar ?? this.avatar,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'email': email,
      'gender': gender,
      'userType': userType,
      'avatar': avatar,
      'dateOfBirth': dateOfBirth,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId']??"",
      username: map['username']??"",
      email: map['email']??"",
      gender: map['gender'] ?? "",
      userType: map['userType']!,
      avatar: map['avatar'] ?? "",
      dateOfBirth: map['dateOfBirth'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      userId,
      username,
      email,
      gender,
      userType,
      avatar,
      dateOfBirth,
    ];
  }
}
