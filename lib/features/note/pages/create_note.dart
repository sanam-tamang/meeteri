import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meeteri/common/repositories/image_uploader_repository.dart';
import 'package:meeteri/common/utils/custom_toast.dart';
import 'package:meeteri/common/widgets/custom_cache_network_image.dart';
import 'package:meeteri/features/note/repositories/note_repositories.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final NoteRepository _noteRepository = NoteRepository();
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Note'),
        actions: [
          ElevatedButton(onPressed: _postNote, child: const Text("Post"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Title',
                      labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      border: InputBorder.none, labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const Gap(250),
                const Divider(),
                IconButton(
                    onPressed: _pickImage, icon: const Icon(Icons.image)),
                const Gap(16),
                SizedBox(
                    height: 150,
                    width: 150,
                    child: CustomCacheNetworkImage(
                      imageUrl: _imageUrl,
                      fit: BoxFit.cover,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final image = await file.readAsBytes();
      _imageUrl =
          await ImageUploaderRepository.getInstance().uploadToFirebase(image);
      setState(() {});
    }
  }

  Future<void> _postNote() async {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String description = _descriptionController.text;

      _noteRepository.createNote(title, description, _imageUrl).then((_) {
        customToast(context, "Note created successful");
        context.pop(); // Go back to previous screen
      }).catchError((error) {
        customToast(context, "Something went wrong $error");
      });
    }
  }
}
