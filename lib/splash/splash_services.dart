import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/screen/login_screen.dart';
import 'package:practice/screen/post_screen.dart';

class SplashServices {
  isLogin(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;
    final user = firebaseAuth.currentUser;
    if (user != null) {
      Timer(
        const Duration(seconds: 3),
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PostScreen(),
            ),
          );
        },
      );
    } else {
      Timer(
        const Duration(seconds: 3),
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        },
      );
    }
  }
}
