import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String postId;
  String userId;
  String postContent;
  String category;
  String imageUrl;
  List<String> hashtags;
  Timestamp timestamp;
  int likes;
  List<String> likedBy;

  Post({
    required this.postId,
    required this.userId,
    required this.postContent,
    required this.category,
    required this.imageUrl,
    required this.hashtags,
    required this.timestamp,
    required this.likes,
    required this.likedBy,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      postId: doc['postId'],
      userId: doc['userId'],
      postContent: doc['postContent'],
      category: doc['category'],
      imageUrl: doc['imageUrl'],
      hashtags: List<String>.from(doc['hashtags']),
      timestamp: doc['timestamp'],
      likes: doc['likes'],
      likedBy: List<String>.from(doc['likedBy']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'userId': userId,
      'postContent': postContent,
      'category': category,
      'imageUrl': imageUrl,
      'hashtags': hashtags,
      'timestamp': timestamp,
      'likes': likes,
      'likedBy': likedBy,
    };
  }
}
