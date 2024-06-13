import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:meeteri/common/utils/custom_toast.dart';
import 'package:meeteri/common/widgets/custom_text_field.dart';
import 'package:toastification/toastification.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  void _addTask() {
    _firestore.collection('users').doc(userId).collection('tasks').add({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'status': 'pending',
      'timestamp': Timestamp.now(),
    }).then((value) {
      context.canPop() ? context.pop() : null;
      customToast(context, "Task added");
    }).catchError((_) {
      customToast(context, "Failed to add task",
          type: ToastificationType.error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CustomTextField(
              controller: _titleController,
              hintText: 'Enter task title',
              labelText: "Title",
            ),
            const Gap(16),
            CustomTextField(
              controller: _descriptionController,
              hintText: "Enter task description",
              labelText: "Description",
              maxLines: 4,
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
