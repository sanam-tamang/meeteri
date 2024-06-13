import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../models/message.dart';

import '../models/chat_room.dart';
import 'package:meeteri/features/profile/models/user.dart' as local;

class MessageRepository {
  MessageRepository._();
  static MessageRepository get instance => MessageRepository._();
  final _firestore = FirebaseFirestore.instance;
  Future<void> sendMessage(CreateMessage message) async {
    final chatRoom =
        _firestore.collection('chatRoomIndividual').doc(message.chatRoomId);

    await chatRoom.update({
      "lastMessage": message.message,
      "timestamp": Timestamp.now(),
      "sendBy": message.sendBy
    });
    String uuid = const Uuid().v1();

    await chatRoom.collection('chat').doc(uuid).set(
        {...message.toMap(), "messageId": uuid, "timestamp": Timestamp.now()});
  }

  Stream<List<GetMessage>> getMessages(String chatRoomId) {
    final snapshot = _firestore
        .collection('chatRoomIndividual')
        .doc(chatRoomId)
        .collection('chat')
        .orderBy('timestamp', descending: false)
        .snapshots();

    return snapshot.asyncMap((query) {
      return Future.wait(query.docs.map((doc) async {
        final data = doc.data();
        return GetMessage.fromMap(data);
      }));
    });
  }
}

class ChatRoomRepository {
  final _firestore = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser;
  ChatRoomRepository._();
  static ChatRoomRepository get instance => ChatRoomRepository._();
  Future<void> createChatRoom(String messagedUserId) async {
    final uuid = const Uuid().v1();
    await _firestore.collection('chatRoomIndividual').doc(uuid).set({
      'participants': [messagedUserId, _currentUser!.uid],
      'chatRoomId': uuid,
      'timestamp': Timestamp.now()
    });
  }

  Stream<List<ChatRoomIndividual>> getMessagedUsers() async* {
    final snapshot = _firestore
        .collection('chatRoomIndividual')
        .orderBy("timestamp", descending: true)
        .where('participants', arrayContains: _currentUser!.uid)
        .snapshots();

    yield* snapshot.asyncMap((query) {
      final queryDoc = Future.wait(query.docs.map((doc) async {
        final Map<String, dynamic> data = doc.data();

        final List participants = data['participants'];
        final messagedUserId = participants
            .where((participant) => participant != _currentUser.uid)
            .toList();
        final user = await UserCollectionRepository.getInstance()
            .getUser(messagedUserId.first);

        final Timestamp timestamp = data['timestamp'] ?? Timestamp.now();
        return ChatRoomIndividual(
          chatRoomId: data['chatRoomId'],
          messagedUser: user!,
          lastMessage: data['lastMessage'],
          lastMessageTime: timestamp.toDate(),
        );
      }));

      return queryDoc;
    });
  }
}

class UserCollectionRepository {
  final _firestore = FirebaseFirestore.instance;
  // final _auth = FirebaseAuth.instance;
  UserCollectionRepository._();
  static UserCollectionRepository getInstance() => UserCollectionRepository._();

//future get
  Future<local.User?> getUser(String userId) async {
    final map = await _firestore.collection('user').doc(userId).get();
    final data = map.data();
    log(data.toString());
    if (data != null) {
      final user = local.User.fromMap(data);
      return user;
    }

    return null;
  }
}
