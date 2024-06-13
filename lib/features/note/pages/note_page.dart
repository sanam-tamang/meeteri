// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:meeteri/common/db_collections.dart';
import 'package:meeteri/common/widgets/custom_cache_network_image.dart';

import 'create_note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({
    super.key,
    required this.userId,
  });
  final String userId;

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      floatingActionButton: FilledButton.icon(
        onPressed: _onAddNote,
        icon: const Icon(Icons.add),
        label: const Text("Add your note"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(DBCollection.user)
            .doc(widget.userId)
            .collection('notes')
            .orderBy('createdAt',
                descending: true) // Order by createdAt timestamp
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No notes found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var note = snapshot.data!.docs[index];
              var data = note.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['title']),
                subtitle: Text(data['description']),
                leading:data['imageUrl']!=null? CustomCacheNetworkImage(
                  imageUrl: data['imageUrl']):
                 Container(color: Colors.grey.shade200,),
                trailing: Text(data['createdAt']
                    .toString()), // Format the timestamp as needed
              );
            },
          );
        },
      ),
    );
  }

  void _onAddNote() {
    showDialog(
        context: context,
        builder: (context) {
          return const CreateNotePage();
        });
  }
}
