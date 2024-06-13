import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meeteri/common/widgets/custom_text_field.dart';
import '../../../common/widgets/app_logo.dart';
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

  UserType? _userType = UserType.student;
  String _username = '';
  String _password = '';
  String _email = '';
  String? _gender;
  String? _dateOfBirth;
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
            // leading: const BackButton(),
            // title: const Text('Create Your Account'),
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

  Widget _buildGenderPicker() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              labelText: 'Select Gender',
            ),
            value: _gender,
            hint: const Text("Select your gender"),
            items: <String>['Male', 'Female', 'Other'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _gender = newValue ?? "Male";
              });
            },
          ),
        ));
  }

  Widget _buildUserTypePage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Start your journey with",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 64),
          ),
          const AppLogo(),
          const Center(
            child: Text(
              'Select Your Role',
              style: TextStyle(fontSize: 32),
            ),
          ),
          const Gap(28),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: UserType.values
                .map((e) => InkWell(
                      onTap: () {
                        _userType = e;
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: e == _userType
                                ? Theme.of(context).colorScheme.primary
                                : Colors.black45,
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.all(12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            e.name.capitalizeFirst(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const Gap(20),
          SizedBox(
            width: double.maxFinite,
            child: FilledButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: const Text('Next'),
            ),
          ),
          TextButton(
            onPressed: _navigateToSignIn,
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(color: Colors.black54)),
                TextSpan(text: "Sign in", style: TextStyle(color: Colors.blue)),
              ]),
            ),
          ),
          const Gap(80),
        ],
      ),
    );
  }

  void _navigateToSignIn() {
    context.goNamed(AppRouteName.signIn);
  }

  Widget _buildUsernamePasswordPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppLogo(),
          CustomTextField(
            controller: _emailController,
            hintText: "Enter your email",
            labelText: "Email",
            onChanged: (value) {
              _email = value;
            },
          ),
          const Gap(20),
          CustomTextField(
            controller: _passwordController,
            hintText: "Enter your password",
            labelText: "Password",
            obscureText: true,
            onChanged: (value) {
              _password = value;
            },
          ),
          const Gap(25),
          SizedBox(
            width: double.maxFinite,
            child: FilledButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: const Text('Next'),
            ),
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
          const AppLogo(),
          _buildGenderPicker(),
          const Gap(20),
          _birthDatePicker(),
          const Gap(25),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      setState(() {
        _dateOfBirth = picked.year.toString();
      });
    }
  }

  Widget _birthDatePicker() {
    return Center(
      child: ElevatedButton(
        onPressed: () => _selectYear(context),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          textStyle: const TextStyle(fontSize: 18.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          _dateOfBirth == null
              ? 'Select birth year'
              : 'Birth year: ${_dateOfBirth.toString()}',
        ),
      ),
    );
  }

  Widget _buildAvatarPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogo(),
          const Text(
            "Profile avatar",
            style: TextStyle(fontSize: 32),
          ),
          const Gap(32),
          _avatar == null
              ? circleCameraButton()
              : CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(_avatar!),
                ),
          const Gap(35),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _onSignUp,
              child: const Text('Continue'),
            ),
          ),
          const Gap(200),
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
      gender: _gender!,
      dateOfBirth: _dateOfBirth.toString(),
      avatar: avatarUrl,
    ));
  }

  Widget circleCameraButton() {
    return Container(
      width: 120.0,
      height: 120.0,
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
          icon: const Icon(Icons.camera_alt, color: Colors.white, size: 30.0),
          onPressed: _pickAvatar),
    );
  }
}
