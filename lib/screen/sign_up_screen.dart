import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practice/screen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final route = MaterialPageRoute(
    builder: (context) => const LoginScreen(),
  );

  bool isSelected = true;
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
          title: const Text('SignUp Screen'),
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
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '*';
                    }
                    return null;
                  },
                  obscureText: isSelected,
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
                      )),
                ),
                const SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus!.unfocus();
                    if (formKey.currentState!.validate()) {
                      try {
                        await firebaseAuth
                            .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            )
                            .then(
                              (UserCredential value) => Fluttertoast.showToast(
                                msg: 'Register Success',
                                backgroundColor: Colors.purple,
                                textColor: Colors.white,
                              ),
                            );
                      } on FirebaseException catch (e) {
                        log('ERROR =============== $e');
                        log('ERROR =============== ${e.code}');
                        log('ERROR =============== ${e.message}');
                        Fluttertoast.showToast(
                          msg: e.code,
                          backgroundColor: Colors.purple,
                          textColor: Colors.white,
                        );
                      }
                      // try {
                      //   await firebaseAuth
                      //       .createUserWithEmailAndPassword(
                      //     email: emailController.text,
                      //     password: passwordController.text,
                      //   )
                      //       .then((UserCredential value) {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content: Text('Register Success'),
                      //       ),
                      //     );
                      //   });
                      // } on FirebaseAuthException catch (e) {
                      //   ScaffoldMessenger.of(context)
                      //       .showSnackBar(SnackBar(content: Text(e.code)));
                      //
                      //   log('Failed with error code =========== : ${e.code}');
                      //   log('MSG =========== : ${e.message}');
                      // }
                    }
                  },
                  color: Colors.purple,
                  minWidth: double.infinity,
                  child: const Text(
                    'SignUp',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an Account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, route);
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
