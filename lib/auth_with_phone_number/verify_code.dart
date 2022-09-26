import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practice/screen/post_screen.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  const VerifyCode({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final varifyCodeController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Verify Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: varifyCodeController,
              onTap: () {},
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('6 digit code'),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus!.unfocus();
                log('AT START =================== ');
                try {
                  final userCredential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: varifyCodeController.text,
                  );
                  log('===================================================');
                  await firebaseAuth.signInWithCredential(userCredential);
                  log('AFTER USER CREDENTIAL ======');

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostScreen(),
                    ),
                  );
                  log('AT END =================');
                } catch (e) {
                  log('AT ERROR SECTION ======================= ');
                  Fluttertoast.showToast(
                    msg: 'Invalid OTP',
                    backgroundColor: Colors.purple,
                    textColor: Colors.white,
                  );
                }
              },
              color: Colors.purple,
              minWidth: double.infinity,
              child: const Text(
                'Verify your OTP',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
