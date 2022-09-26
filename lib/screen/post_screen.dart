import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practice/screen/login_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('Post'),
      actions: [
        IconButton(
          onPressed: () {
            firebaseAuth
                .signOut()
                .then(
                  (value) => Fluttertoast.showToast(msg: 'User Logout Success'),
                )
                .then(
                  (value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                );
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    ));
  }
}
