import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:tamang_food_service/screens/forgetpassword_screen2.dart';
import 'package:tamang_food_service/screens/widget/custom_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController email = TextEditingController();
  reset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 80),
                  Text(
                    'Forgot Password',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                'Forgot Password ',
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Enter your email address and we will send you a reset instructions.',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  label: Text(
                    'EMAIL ADDRESS',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              custom_button(
                onpressed: () {
                  reset();
                },
                buttonText: 'RESET PASSWORD',
                fontsize: 19,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
