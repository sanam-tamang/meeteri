// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:meeteri/common/utils/custom_toast.dart';
import 'package:meeteri/common/widgets/custom_cache_network_image.dart';
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
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Card.filled(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    userInfoWidget(post.userId),
                    const Gap(20),
                    Text(post.postContent),
                    _postCard(post)
                  ],
                ),
              ),
            ),
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
              child: _userTopPost(
                  username: data['username'], avatar: data['avatar']));
        });
  }

  void _createChatRoom(String messagedUserId) {
    ChatRoomRepository.instance.createChatRoom(messagedUserId).then((value) {
      customToast(context, "Chat room created");
    }).catchError((e) {
      customToast(context, e.toString());
    });
  }

  Widget _postCard(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        if (post.imageUrl != "") ...[
          const SizedBox(height: 8.0),
          SizedBox(
              height: 250,
              width: double.infinity,
              child: CustomCacheNetworkImage(
                imageUrl: post.imageUrl,
                fit: BoxFit.cover,
              )),
        ],
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.thumbsUp),
                  onPressed: () {
                    // Handle like action
                  },
                ),
                Text('${post.likes}'),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.comment),
                  onPressed: () {
                    // Handle comment action
                  },
                ),
                const Text("1"),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.share),
                  onPressed: () {
                    // Handle share action
                  },
                ),
                const Text('2'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _userTopPost({required String username, String? avatar}) {
    return Row(
      children: [
        avatar != null
            ? CircleAvatar(
                radius: 25,
                backgroundImage: CachedNetworkImageProvider(avatar),
              )
            : CircleAvatar(
                radius: 25,
                child: Container(
                  color: Colors.grey.shade400,
                ),
              ),
        const SizedBox(width: 8.0),
        Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
      ],
    );
  }
}
