import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meeteri/common/db_collections.dart';


class NoteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createNote(
      String title, String description, String? imageUrl) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection(DBCollection.user).doc(currentUser.uid). collection('notes').add({
          'userId': currentUser.uid,
          'title': title,
          'description': description,
          'imageUrl': imageUrl,
          'createdAt': Timestamp.now(),
        });
      } else {
        throw Exception('User not logged in.');
      }
    } catch (e) {
      throw Exception('Failed to create note: $e');
    }
  }
}
