import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeteri/common/theme/app_theme.dart';
import 'package:meeteri/dependency_injection.dart';
import 'package:meeteri/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:meeteri/router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
       
      ],
      child:  MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Meeteri',
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          routerConfig: AppRoute.call(),
        )
    );
    
  }
}
