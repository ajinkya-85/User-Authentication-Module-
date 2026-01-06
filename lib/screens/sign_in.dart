import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_auth_module/reusable_widgets/textfield.dart';
import 'package:user_auth_module/reusable_widgets/buttons.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In Screen',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 80),
              reusableTextField(
                "Enter Email",
                Icons.mail_outline,
                false,
                _emailTextController,
              ),
              SizedBox(height: 20),
              reusableTextField(
                "Enter Password",
                Icons.lock_outline,
                true,
                _passwordTextController,
              ),
              SizedBox(height: 20),
              buttonsReuable("Sign In", context, () async {
                if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                ).hasMatch(_emailTextController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a valid email")),
                  );
                  return;
                }
                if (_passwordTextController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter password")),
                  );
                  return;
                }

                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      );

                  DocumentSnapshot userDoc = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userCredential.user!.uid)
                      .get();

                  Map<String, dynamic>? userData =
                      userDoc.data() as Map<String, dynamic>?;

                  print("Logged In");
                  if (context.mounted) {
                    Navigator.pushNamed(
                      context,
                      '/home',
                      arguments: {
                        'username': userData?['username'] ?? '',
                        'email': _emailTextController.text,
                        'password': _passwordTextController.text,
                        'mobile': userData?['mobile'] ?? '',
                        'address': userData?['address'] ?? '',
                      },
                    );
                  }
                } catch (error) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Error: ${error.toString()}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.blueGrey,
                      ),
                    );
                  }
                }
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      " Sign Up",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
