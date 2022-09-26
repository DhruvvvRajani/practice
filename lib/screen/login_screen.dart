import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practice/auth_with_phone_number/login_with_phone_number.dart';
import 'package:practice/screen/post_screen.dart';
import 'package:practice/screen/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isSelected = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final route = MaterialPageRoute(
    builder: (context) => const SignUpScreen(),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Login Screen'),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '*';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Email'),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: isSelected,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '*';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text('Password'),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      },
                      icon: isSelected
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      log('CURRENT USER EMAIL ============ ${firebaseAuth.currentUser!.email}');
                      log('CURRENT USER UID ============ ${firebaseAuth.currentUser!.uid}');
                      FocusManager.instance.primaryFocus!.unfocus();
                      try {
                        await firebaseAuth
                            .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            )
                            .then(
                              (value) => Fluttertoast.showToast(
                                msg: 'Login Success',
                                backgroundColor: Colors.purple,
                                textColor: Colors.white,
                              ).then(
                                (value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PostScreen(),
                                  ),
                                ),
                              ),
                            );
                      } on FirebaseException catch (e) {
                        log('ERROR ============ $e');
                        log('ERROR ============ ${e.code}');
                        log('ERROR ============ ${e.message}');
                        Fluttertoast.showToast(
                          msg: e.code,
                          backgroundColor: Colors.purple,
                          textColor: Colors.white,
                        );
                      }
                    }
                  },
                  color: Colors.purple,
                  minWidth: double.infinity,
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an Account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, route);
                      },
                      child: const Text('SignUp'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginWithPhoneNumber(),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text('Login with Phone Number'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
