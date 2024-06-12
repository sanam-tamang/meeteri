// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/common/enum.dart';
import '/common/typedef.dart';
import '/core/failure/failure.dart';
import '/core/internet/internet_checker.dart';
import '/features/profile/repositories/user_repository.dart';

///common error method
const String _errorMessage =
    "An error occurred while signing up. Please try again later.";

sealed class BaseAuthRepository {
  FutureEither<String> signUp(
      {required String email,
      required String password,
      required String dateOfBirth,
      required String avatar,
      required String username,
      required String gender,
      required UserType userType});
  FutureEither<String> signIn(
      {required String email, required String password});
  FutureEither<void> signOut();
  FutureEither<void> signInAsGuest();
}

class AuthRepository implements BaseAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final BaseInternetChecker _internetInfo;
  final BaseUserRepository _userRepository;
  AuthRepository(
      {required BaseInternetChecker internetInfo,
      required BaseUserRepository userRepository,})
      : _userRepository = userRepository,
        _internetInfo = internetInfo;
  @override
  FutureEither<String> signIn(
      {required String email, required String password}) async {
    try {
      if (await _internetInfo.isConnecsted) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        return const Right("User signed in");
      } else {
        return Left(InternetFailure());
      }
    } on FirebaseAuthException catch (e) {
      return Left(FailureWithMessage(e.message ?? _errorMessage));
    } catch (e) {
      return Left(FailureWithMessage(_errorMessage));
    }
  }

  @override
  FutureEither<void> signInAsGuest() {
    // TODO: implement signInAsGuest
    throw UnimplementedError();
  }

  @override
  FutureEither<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  FutureEither<String> signUp(
      {required String email,
      required String password,
      required String dateOfBirth,
      required String avatar,
      required UserType userType,
      required String gender,
      required String username}) async {
    try {
      if (await _internetInfo.isConnecsted) {
        final user = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        _userRepository.addUserInfo(
            userId: user.user!.uid,
            username: username,
            avatar: avatar,
            userType: userType,
            gender: gender,
            dateOfBirth: dateOfBirth);

        return const Right("User created");
      } else {
        return Left(InternetFailure());
      }
    } on FirebaseAuthException catch (e) {
      return Left(FailureWithMessage(e.message ?? _errorMessage));
    } catch (e) {
      return Left(FailureWithMessage(_errorMessage));
    }
  }
}
