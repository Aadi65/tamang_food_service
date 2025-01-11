import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tamang_food_service/screens/homepage_screen.dart';
import 'package:tamang_food_service/screens/signin_screen.dart';
//import 'package:tamang_food_service/screens/verify_Screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePageScreen();
          } else {
            return SigninScreen();
          }
        },
      ),
    );
  }
}
