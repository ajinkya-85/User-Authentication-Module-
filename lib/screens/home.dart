import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_auth_module/reusable_widgets/buttons.dart';
import 'package:user_auth_module/reusable_widgets/textfield.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> _fetchUserData(String uid) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      print('Fetched doc exists: ${doc.exists}');
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print('Fetched data: $data');
        setState(() {
          _usernameController.text = data['username'] ?? '';
          _emailController.text = data['email'] ?? '';
          _mobileController.text = data['mobile'] ?? '';
          _addressController.text = data['address'] ?? '';
        });
      } else {
        print('Document does not exist for UID: $uid');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safely access arguments and current user details
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final user = FirebaseAuth.instance.currentUser;

    if (args != null) {
      // Set initial values from args
      _usernameController.text = args['username'] ?? '';
      _emailController.text = args['email'] ?? '';
      _mobileController.text = args['mobile'] ?? '';
      _addressController.text = args['address'] ?? '';
    }

    if (user != null) {
      // Always fetch latest data from Firestore
      _fetchUserData(user.uid);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'username': _usernameController.text,
        'email': _emailController.text,
        'mobile': _mobileController.text,
        'address': _addressController.text,
      }, SetOptions(merge: true));

      if (_usernameController.text.isNotEmpty) {
        await user.updateDisplayName(_usernameController.text);
      }

      if (_emailController.text.isNotEmpty &&
          _emailController.text != user.email) {
        await user.verifyBeforeUpdateEmail(_emailController.text);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Verification email sent. Please verify to update email.",
              ),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Profile Updated")));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
      }
    }
  }

  Future<void> _changePassword() async {
    if (_passwordController.text.isEmpty ||
        _passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match or are empty.")),
      );
      return;
    }
    try {
      await FirebaseAuth.instance.currentUser?.updatePassword(
        _passwordController.text,
      );
      if (mounted) {
        _passwordController.clear();
        _confirmPasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password changed successfully.")),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message ??
                  "An error occurred. Please sign out and sign in again.",
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  reusableTextField(
                    "Username",
                    Icons.person_outline,
                    false,
                    _usernameController,
                  ),
                  SizedBox(height: 20),
                  reusableTextField(
                    "Email",
                    Icons.mail_outline,
                    false,
                    _emailController,
                  ),
                  SizedBox(height: 20),
                  reusableTextField(
                    "Mobile Number",
                    Icons.phone,
                    false,
                    _mobileController,
                  ),
                  SizedBox(height: 20),
                  reusableTextField(
                    "Address",
                    Icons.home,
                    false,
                    _addressController,
                  ),
                  SizedBox(height: 20),
                  reusableTextField(
                    "New Password",
                    Icons.lock_outline,
                    true,
                    _passwordController,
                  ),
                  SizedBox(height: 20),
                  reusableTextField(
                    "Confirm New Password",
                    Icons.lock_outline,
                    true,
                    _confirmPasswordController,
                  ),
                  SizedBox(height: 20),
                  buttonsReuable("Update Profile", context, _updateProfile),
                  buttonsReuable("Change Password", context, _changePassword),
                  buttonsReuable("Log Out", context, () async {
                    await FirebaseAuth.instance.signOut();
                    print("Signed Out");
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/signin',
                        (route) => false,
                      );
                    }
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
