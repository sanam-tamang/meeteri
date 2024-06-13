// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:meeteri/features/post/utils.dart';

import '../../post/models/post.dart';

class PostCardsWidget extends StatelessWidget {
  const PostCardsWidget({
    super.key,
    required this.posts,
    required this.category,
  });
  final List<Post> posts;
  final String category;
  @override
  Widget build(BuildContext context) {
    final searchedPosts = binarySearchPosts(posts, category);
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        itemCount: searchedPosts.length,
        itemBuilder: (context, index) {
          final post = searchedPosts[index];
          return Text(post.category);
        });
  }
}
