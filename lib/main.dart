import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:user_auth_module/firebase_options.dart';
import 'package:user_auth_module/screens/home.dart';
import 'package:user_auth_module/screens/sign_in.dart';
import 'package:user_auth_module/screens/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Firebase initialization error (can be ignored if duplicate-app)
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignIn(),
      routes: {
        '/signin': (context) => const SignIn(),
        '/signup': (context) => const SignUp(),
        '/home': (context) => const Home(),
      },
    );
  }
}
