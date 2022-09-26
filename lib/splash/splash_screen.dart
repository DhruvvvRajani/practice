import 'package:flutter/material.dart';
import 'package:practice/screen/login_screen.dart';
import 'package:practice/splash/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final route = MaterialPageRoute(
    builder: (context) => const LoginScreen(),
  );

  @override
  void initState() {
    SplashServices splashServices = SplashServices();
    splashServices.isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'FireBase Practice',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
