// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:meeteri/common/db_collections.dart';
import 'package:meeteri/features/note/pages/create_note.dart';
import 'package:meeteri/features/profile/repositories/user_repository.dart';
import 'package:meeteri/router.dart';

import '../../../common/utils/custom_toast.dart';
import '../../chat/repositories/message_repository.dart';

class UserProfilePage extends StatefulWidget {
  final String? userId;

  const UserProfilePage({
    super.key,
    this.userId,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
        title: const Text('Profile'),
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
                        ? Center(
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage(userData['avatar']),
                            ),
                          )
                        : Center(
                            child: CircleAvatar(
                              radius: 70,
                              child: Container(
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                    const Gap(20),
//TODO::: fsdfsd fsf
                    widget.userId != null
                        ? FilledButton(
                            onPressed: () => _createChatRoom(widget.userId!),
                            child: const Text("Chat anonymously"))
                        : FilledButton(
                            onPressed: () {}, child: const Text("Edit")),

                    Text('${userData['username'] ?? ''}'),
                    Text('${userData['userType']}'),
                    Text('Gender: ${userData['gender'] ?? ''}'),
                    Text('Date of Birth: ${userData['dateOfBirth'] ?? ''}'),
                    const Gap(40),
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

  void _createChatRoom(String messagedUserId) {
    ChatRoomRepository.instance.createChatRoom(messagedUserId).then((value) {
      customToast(context, "Chat room created");
      context.pushNamed(AppRouteName.messagedUserPage);
    }).catchError((e) {
      customToast(context, e.toString());
    });
  }
}
