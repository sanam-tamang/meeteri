// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meeteri/common/utils/custom_toast.dart';
import 'package:meeteri/features/chat/repositories/message_repository.dart';
import 'package:meeteri/features/post/utils.dart';
import 'package:meeteri/router.dart';

import '../../post/models/post.dart';

class PostCardsWidget extends StatefulWidget {
  const PostCardsWidget({
    super.key,
    required this.posts,
    required this.category,
  });
  final List<Post> posts;
  final String category;

  @override
  State<PostCardsWidget> createState() => _PostCardsWidgetState();
}

class _PostCardsWidgetState extends State<PostCardsWidget> {
  @override
  Widget build(BuildContext context) {
    final searchedPosts = binarySearchPosts(widget.posts, widget.category);
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        itemCount: searchedPosts.length,
        itemBuilder: (context, index) {
          final post = searchedPosts[index];
          return Column(
            children: [
              userInfoWidget(post.userId),
              Text(post.category),
            ],
          );
        });
  }

  Widget userInfoWidget(String userId) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('user').doc(userId).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No user data found'));
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;
          return GestureDetector(
            onTap: () => _createChatRoom(data['userId']),
            child: SizedBox(height: 40, child: Text(data['username'])),
          );
        });
  }

  void _createChatRoom(String messagedUserId) {
    ChatRoomRepository.instance.createChatRoom(messagedUserId).then((value) {
      customToast(context, "Chat room created");
    }).catchError((e) {
      customToast(context, e.toString());
    });
  }
}
