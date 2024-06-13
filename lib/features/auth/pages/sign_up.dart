import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../dependency_injection.dart';
import '/common/extensions.dart';
import '/common/utils/username_generator.dart';
import '/router.dart';
import '../../../common/utils/floating_loading_indicator.dart';
import '/common/enum.dart';
import '/common/utils/custom_toast.dart';
import '/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:toastification/toastification.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  UserType? _userType;
  String _username = '';
  String _password = '';
  String _email = '';
  String _gender = '';
  String _dateOfBirth = '';
  File? _avatar;

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _genderController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  late AuthBloc _authBloc;
  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatar = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    _authBloc = sl<AuthBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _genderController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registration Form'),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, state) {
            state.maybeMap(
                loading: (_) => floatingLoadingIndicator(context),
                failure: (f) {
                  customToast(context, f.failure.getMessage,
                      type: ToastificationType.error);
                  context.pop();
                },
                loaded: (s) {
                  customToast(context, s.message);
                  context.pop();
                  context.goNamed(AppRouteName.home);
                },
                orElse: () {});
          },
          child: Column(
            children: [
              LinearProgressIndicator(
                value:
                    (_currentPage + 1) / 4, // Adjust based on number of pages
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildUserTypePage(),
                    _buildUsernamePasswordPage(),
                    _buildGenderDateOfBirthPage(),
                    _buildAvatarPage(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildUserTypePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Select User Type:'),
          ListTile(
            title: const Text('Counselor'),
            leading: Radio<UserType>(
              value: UserType.counselor,
              groupValue: _userType,
              onChanged: (UserType? value) {
                setState(() {
                  _userType = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Myself'),
            leading: Radio<UserType>(
              value: UserType.student,
              groupValue: _userType,
              onChanged: (UserType? value) {
                setState(() {
                  _userType = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('For child'),
            leading: Radio<UserType>(
              value: UserType.parent,
              groupValue: _userType,
              onChanged: (UserType? value) {
                setState(() {
                  _userType = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  Widget _buildUsernamePasswordPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'email'),
            obscureText: false,
            onChanged: (value) {
              _email = value;
            },
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            onChanged: (value) {
              _password = value;
            },
          ),
          ElevatedButton(
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderDateOfBirthPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _genderController,
            decoration: const InputDecoration(labelText: 'Gender'),
            onChanged: (value) {
              _gender = value;
            },
          ),
          TextField(
            controller: _dateOfBirthController,
            decoration: const InputDecoration(labelText: 'Date of Birth'),
            onChanged: (value) {
              _dateOfBirth = value;
            },
          ),
          ElevatedButton(
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _avatar == null
              ? const Text('No image selected.')
              : CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(_avatar!),
                ),
          ElevatedButton(
            onPressed: _pickAvatar,
            child: const Text('Pick Avatar'),
          ),
          ElevatedButton(
            onPressed: _onSignUp,
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  Future<void> _onSignUp() async {
    String avatarUrl = '';
    if (_avatar != null) {
      // Upload the avatar to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('avatars/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(_avatar!);
      avatarUrl = await storageRef.getDownloadURL();
    }

    _username = generateUsername();
    _authBloc.add(AuthEvent.signUp(
      email: _email,
      userType: _userType ?? UserType.student,
      username: _username,
      password: _password,
      gender: _gender,
      dateOfBirth: _dateOfBirth,
      avatar: avatarUrl,
    ));
  }
}
