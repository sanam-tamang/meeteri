import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createPost(Post post) async {
    await _db.collection('posts').doc(post.postId).set(post.toJson());
  }

  Future<Post?> getPost(String postId) async {
    DocumentSnapshot doc = await _db.collection('posts').doc(postId).get();
    if (doc.exists) {
      return Post.fromDocument(doc);
    }
    return null;
  }

  Future<void> updatePost(Post post) async {
    await _db.collection('posts').doc(post.postId).update(post.toJson());
  }

  Future<List<Post>> getAllPosts() async {
    QuerySnapshot querySnapshot = await _db.collection('posts').get();
    return querySnapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
  }

  Future<void> deletePost(String postId) async {
    await _db.collection('posts').doc(postId).delete();
  }

  Future<void> likePost(String postId, String userId) async {
    DocumentReference postRef = _db.collection('posts').doc(postId);
    DocumentSnapshot doc = await postRef.get();

    if (doc.exists) {
      Post post = Post.fromDocument(doc);
      if (!post.likedBy.contains(userId)) {
        post.likedBy.add(userId);
        post.likes += 1;
        await postRef.update({
          'likes': post.likes,
          'likedBy': post.likedBy,
        });
      }
    }
  }

  Future<void> unlikePost(String postId, String userId) async {
    DocumentReference postRef = _db.collection('posts').doc(postId);
    DocumentSnapshot doc = await postRef.get();

    if (doc.exists) {
      Post post = Post.fromDocument(doc);
      if (post.likedBy.contains(userId)) {
        post.likedBy.remove(userId);
        post.likes -= 1;
        await postRef.update({
          'likes': post.likes,
          'likedBy': post.likedBy,
        });
      }
    }
  }
}
