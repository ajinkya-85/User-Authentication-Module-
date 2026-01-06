import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_auth_module/reusable_widgets/textfield.dart';
import 'package:user_auth_module/reusable_widgets/buttons.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _mobileTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();

  Future<void> _signUp() async {
    if (_usernameTextController.text.isEmpty ||
        _emailTextController.text.isEmpty ||
        _mobileTextController.text.isEmpty ||
        _addressTextController.text.isEmpty ||
        _passwordTextController.text.isEmpty ||
        _confirmPasswordTextController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all info")));
      return;
    }
    if (_passwordTextController.text != _confirmPasswordTextController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(_emailTextController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email")),
      );
      return;
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(_mobileTextController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid 10-digit mobile number"),
        ),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text,
          );

      try {
        String uid = userCredential.user!.uid;
        print("User UID: $uid");
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': _usernameTextController.text,
          'email': _emailTextController.text,
          'mobile': _mobileTextController.text,
          'address': _addressTextController.text,
          'uid': uid,
        });
        print(
          "User data saved to Firestore: username=${_usernameTextController.text}, address=${_addressTextController.text}",
        );
      } catch (firestoreError) {
        print("Firestore error: $firestoreError");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to save user data: $firestoreError"),
            ),
          );
        }
        // Still navigate, but inform user
      }

      if (context.mounted) {
        print("Created New Account");
        Navigator.pushReplacementNamed(
          context,
          '/home',
          arguments: {
            'username': _usernameTextController.text,
            'email': _emailTextController.text,
            'password': _passwordTextController.text,
            'mobile': _mobileTextController.text,
            'address': _addressTextController.text,
          },
        );
      }
    } catch (error) {
      print("Error ${error.toString()}");
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: ${error.toString()}")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  reusableTextField(
                    "Enter Username",
                    Icons.person_outline,
                    false,
                    _usernameTextController,
                  ),
                  SizedBox(height: 20),
                  reusableTextField(
                    "Enter Email ID",
                    Icons.mail_outline,
                    false,
                    _emailTextController,
                  ),
                  SizedBox(height: 20),
                  reusableTextField(
                    "Enter Mobile Number",
                    Icons.phone,
                    false,
                    _mobileTextController,
                  ),
                  SizedBox(height: 20),
                  reusableTextField(
                    "Enter Address",
                    Icons.home,
                    false,
                    _addressTextController,
                  ),
                  SizedBox(height: 20),
                  reusableTextField(
                    "Enter Password",
                    Icons.lock_outline,
                    true,
                    _passwordTextController,
                  ),
                  SizedBox(height: 20),
                  reusableTextField(
                    "Confirm Password",
                    Icons.lock_outline,
                    true,
                    _confirmPasswordTextController,
                  ),
                  SizedBox(height: 20),
                  buttonsReuable("Sign Up", context, () {
                    _signUp();
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
