import 'package:dartz/dartz.dart';
import '/common/db_collections.dart';
import '/common/enum.dart';
import '/common/typedef.dart';
import '/core/failure/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


sealed class BaseUserRepository {
  FutureEither<String> addUserInfo(
      {required String userId,
      required String username,
      required String avatar,
      required UserType userType,
      required String gender,
      required String dateOfBirth,
      required String email
      });

  FutureEither<String> addCounselorInfo({
    required String userId,
    required String phoneNumber,
    required String address,
    required String specialization,
    required String hospital,
  });

  // Future<UserModel?> getUser(String userId) ;


  
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
    required String email
  }) async {
    try {
      await _firestore.collection(DBCollection.user).doc(userId).set({
        'userId': userId, 
        'username': username,
        'avatar': avatar,
        'userType': userType.name,
        'gender': gender,
        'dateOfBirth': dateOfBirth,
        'email': email,
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

  // @override
  // Future<UserModel?> getUser(String userId) async {
  //   final map = await _firestore.collection('user').doc(userId).get();
  //   final data = map.data();
  //   if (data != null) {
  //     final user = UserModel.fromJson(data);
  //     return user;
  //   }

  //   return null;
  // }
}
