// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meeteri/dependency_injection.dart';
import 'package:meeteri/features/post/blocs/post_bloc/post_bloc.dart';
import '/common/repositories/image_uploader_repository.dart';

import '/common/utils/custom_toast.dart';
import '/common/widgets/custom_cache_network_image.dart';
import '/features/post/models/post.dart';
import '/features/profile/repositories/user_repository.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

import '../../profile/repositories/current_user_repository.dart';
import '/features/post/repositories/post_repositories.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({
    super.key,
    required this.postType,
  });
  final String postType;

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final PostRepository _postRepository = PostRepository();

  String _userId =
      'user123'; // Example user ID, should be fetched from logged in user
  String _postContent = '';
  String _category = 'study-material';
  String? _imageUrl;
  final List<String> _hashtags = [];
  final Timestamp _timestamp = Timestamp.now();
  final int _likes = 0;
  final List<String> _likedBy = [];

  Uint8List? _image;

  @override
  void initState() {
    _category = widget.postType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          ElevatedButton(onPressed: _onCreatePost, child: const Text("Post"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Write a post...', border: InputBorder.none),
                  onSaved: (value) {
                    _postContent = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the post content';
                    }
                    return null;
                  },
                ),
                const Gap(250),
                const Divider(),
                IconButton(
                    onPressed: _pickImage, icon: const Icon(Icons.image)),
                const SizedBox(height: 15),
                _imageUrl != null
                    ? SizedBox(
                        height: 150,
                        width: 200,
                        child: CustomCacheNetworkImage(
                          imageUrl: _imageUrl,
                          fit: BoxFit.cover,
                          borderRadius: 5.0,
                        ),
                      )
                    : const SizedBox()
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
      _image = await file.readAsBytes();
      _imageUrl =
          await ImageUploaderRepository.getInstance().uploadToFirebase(_image!);
      setState(() {});
    }
  }

  Future<void> _onCreatePost() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final postId = const Uuid().v4();
      final user = await getCurrenUser();
      _userId = user!.uid;
      Post newPost = Post(
        postId: postId,
        userId: _userId,
        postContent: _postContent,
        category: _category,
        imageUrl: _imageUrl ?? "",
        hashtags: _hashtags,
        timestamp: _timestamp,
        likes: _likes,
        likedBy: _likedBy,
      );
      try {
        _postRepository.createPost(newPost).then((_) {
          customToast(
            context,
            'Post created successfully',
          );
          sl<PostBloc>().add(const PostEvent.get());
          _formKey.currentState!.reset();
          context.pop();
        }).catchError((error) {
          customToast(context, 'Failed to create post: $error');
        });
      } catch (e) {
        // ignore: use_build_context_synchronously
        customToast(context, e.toString(), type: ToastificationType.error);
      }
    }
  }
}
