import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meeteri/features/task/pages/add_task.dart';
import '../models/task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  String filter = 'all';

  Stream<QuerySnapshot> _getTaskStream() {
    if (filter == 'all') {
      return _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .orderBy('timestamp')
          .snapshots();
    } else if (filter == 'pending') {
      return _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .where('isCompleted', isEqualTo: false)
          .orderBy('timestamp')
          .snapshots();
    } else if (filter == 'completed') {
      return _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .where('isCompleted', isEqualTo: true)
          .orderBy('timestamp')
          .snapshots();
    } else {
      return _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .snapshots();
    }
  }

  Future<void> _toggleTaskStatus(Task task) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(task.id)
        .update({
      'isCompleted': !task.isCompleted,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FilledButton.icon(
        onPressed: _onAddTask,
        label: const Text("Add your task"),
        icon: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                filter = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'all', child: Text('All')),
              const PopupMenuItem(value: 'pending', child: Text('Pending')),
              const PopupMenuItem(value: 'completed', child: Text('Completed')),
            ],
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getTaskStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final tasks = snapshot.data!.docs
              .map((doc) =>
                  Task.fromJson(doc.data() as Map<String, dynamic>, doc.id))
              .toList();
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              var task = tasks[index];
              return ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration:
                        task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(task.description),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) {
                    _toggleTaskStatus(task);
                  },
                ),
                onTap: () {
                  _toggleTaskStatus(task);
                },
              );
            },
          );
        },
      ),
    );
  }

  void _onAddTask() {
    showDialog(
        context: context,
        builder: (context) {
          return const AddTaskPage();
        });
  }
}
