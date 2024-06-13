import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:meeteri/common/widgets/app_logo.dart';
import 'package:toastification/toastification.dart';
import '../../../dependency_injection.dart';
import '/common/extensions.dart';
import '/common/utils/custom_toast.dart';
import '/common/utils/floating_loading_indicator.dart';
import '/common/widgets/custom_text_field.dart';
import '/features/auth/blocs/auth_bloc/auth_bloc.dart';
import '/router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  late AuthBloc _authBloc;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _authBloc = sl<AuthBloc>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
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
          child: Form(
            key: _form,
            child: Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Column(
                  children: [
                    const AppLogo(),
                    Text(
                      "Always here, Always caring ",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    _customGap(46),
                    // const Spacer(),
                    CustomTextField(
                      hintText: 'Enter your email',
                      controller: emailController,
                      labelText: 'Email',
                    ),
                    _customGap(),
                    CustomTextField(
                      hintText: 'Enter your password',
                      controller: passwordController,
                      labelText: "Password",
                      obscureText: true,
                    ),
                    _customGap(48),

                    FilledButton(
                        onPressed: () => login(), child: const Text("Login")),

                    _customGap(),

                    TextButton(
                      onPressed: _navigateToSignUpPage,
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                              text: "Don't have an account yet?",
                              style: TextStyle(color: Colors.black54)),
                          TextSpan(
                              text: "Sign up",
                              style: TextStyle(color: Colors.blue)),
                        ]),
                      ),
                    ),
                    // const Spacer(),

                    const Gap(100),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _customGap([double? size = 24]) {
    return SizedBox(
      height: size,
    );
  }

  void _navigateToSignUpPage() {
    context.pushNamed(AppRouteName.signUp);
  }

  void login() {
    _authBloc.add(AuthEvent.signIn(
        email: emailController.text, password: passwordController.text));
  }
}
