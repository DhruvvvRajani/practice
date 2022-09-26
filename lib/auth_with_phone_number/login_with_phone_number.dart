import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practice/auth_with_phone_number/verify_code.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneController = TextEditingController(text: '+91');
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login with Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: phoneController,
              onTap: () {},
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter your Number'),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () {
                FocusManager.instance.primaryFocus!.unfocus();
                firebaseAuth.verifyPhoneNumber(
                  phoneNumber: phoneController.text,
                  verificationCompleted: (_) {},
                  verificationFailed: (e) {
                    Fluttertoast.showToast(
                      msg: e.toString(),
                      backgroundColor: Colors.purple,
                    );
                  },
                  codeSent: (String verificationId, int? verifyCode) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerifyCode(
                          verificationId: verificationId,
                        ),
                      ),
                    );
                  },
                  codeAutoRetrievalTimeout: (e) {
                    Fluttertoast.showToast(
                      msg: 'Timeout',
                      backgroundColor: Colors.purple,
                    );
                  },
                );
              },
              color: Colors.purple,
              minWidth: double.infinity,
              child: const Text(
                'Send Verify Code',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
