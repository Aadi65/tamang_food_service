import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamang_food_service/screens/forgetpassword_screen.dart';
import 'package:tamang_food_service/screens/homepage_screen.dart';
import 'package:tamang_food_service/screens/signup_screen.dart';
import 'package:tamang_food_service/screens/widget/custom_button.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email == "" || password == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(" Please fill all the details"),
        ),
      );
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePageScreen(),
            ),
          );
        }
      } on FirebaseException catch (e) {
        print(e.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    const SizedBox(width: 135),
                    Text(
                      'Sign In',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Welcome to Tamang Food Services ',
                  style: GoogleFonts.poppins(
                    fontSize: 35,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Enter your Phone number or Email address for sign in\nEnjoy your food :)',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    suffixIcon: Icon(
                      Icons.check,
                      color: Color(0xFFEEA734),
                    ),
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
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    suffixIcon: Icon(
                      Icons.visibility_off,
                      color: Color(0xFFEEA734),
                    ),
                    label: Text(
                      'PASSWORD',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                custom_button(
                  onpressed: () {
                    signin();
                  },
                  buttonText: 'SIGN IN ',
                  fontsize: 19,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have account?',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Create new account',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.orange.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Image.asset('assets/Social accounts.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
