import 'package:dartz/dartz.dart';
import 'package:meeteri/common/db_collections.dart';
import 'package:meeteri/common/enum.dart';
import 'package:meeteri/common/typedef.dart';
import 'package:meeteri/core/failure/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

sealed class BaseUserRepository {
  FutureEither<String> addUserInfo(
      {required String userId,
      required String username,
      required String avatar,
      required UserType userType,
      required String gender,
      required String dateOfBirth});

  FutureEither<String> addCounselorInfo({
    required String userId,
    required String phoneNumber,
    required String address,
    required String specialization,
    required String hospital,
  });
}

class UserRepository implements BaseUserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  FutureEither<String> addUserInfo({
    required String userId,
    required String username,
    required String avatar,
    required UserType userType,
    required String gender,
    required String dateOfBirth,
  }) async {
    try {
      await _firestore.collection(DBCollection.user).doc(userId).set({
        'userId': userId, 
        'username': username,
        'avatar': avatar,
        'userType': userType.toString(),
        'gender': gender,
        'dateOfBirth': dateOfBirth,
      });

      return const Right('User info added successfully');
    } catch (e) {
      return Left(FailureWithMessage(e.toString()));
    }
  }

  @override
  FutureEither<String> addCounselorInfo({
    required String userId,
    required String phoneNumber,
    required String address,
    required String specialization,
    required String hospital,
  }) async {
    try {
      await _firestore.collection('counselors').doc(userId).set({
        'userId': userId,
        'phoneNumber': phoneNumber,
        'address': address,
        'specialization': specialization,
        'hospital': hospital,
      });

      return const Right('Counselor info added successfully');
    } catch (e) {
      return Left(FailureWithMessage(e.toString()));
    }
  }
}
