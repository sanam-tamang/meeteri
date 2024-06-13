// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meeteri/common/db_collections.dart';
import 'package:meeteri/features/note/pages/create_note.dart';
import 'package:meeteri/features/profile/repositories/user_repository.dart';
import 'package:meeteri/router.dart';

class UserProfileScreen extends StatefulWidget {
  final String? userId;

  const UserProfileScreen({
    super.key,
    this.userId,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late String? userId;

  @override
  void initState() {
    userId = widget.userId ?? FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(DBCollection.user)
            .doc(userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userData["avatar"] != null || userData["avatar"] != ""
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(userData['avatar']),
                          )
                        : CircleAvatar(
                            radius: 50,
                            child: Container(
                              color: Colors.grey.shade200,
                            ),
                          ),
                    const SizedBox(height: 20),
                    Text('Username: ${userData['username'] ?? ''}'),
                    Text('User Type: ${userData['userType'] ?? ''}'),
                    Text('Gender: ${userData['gender'] ?? ''}'),
                    Text('Date of Birth: ${userData['dateOfBirth'] ?? ''}'),
                    ListTile(
                      onTap: () => context.pushNamed(AppRouteName.showNote,
                          extra: userId),
                      title: const Text("Notes"),
                    ),
                    ListTile(
                      onTap: () => context.pushNamed(
                        AppRouteName.habitPage,
                      ),
                      title: const Text("Habits"),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
