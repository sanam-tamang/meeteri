import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<User?> getCurrenUser() async {
  final user = auth.currentUser;


  if (user == null) {
    final authStateChanges = auth.authStateChanges();
    final userStream = await authStateChanges.first;

    return userStream;
  } else {
    return user;
  }
}
