import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tamang_food_service/screens/signin_screen.dart';
//import 'package:google_fonts/google_fonts.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageScreen> {
  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SigninScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: logOut,
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }
}
