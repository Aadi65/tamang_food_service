import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamang_food_service/screens/homepage_screen.dart';
import 'package:tamang_food_service/screens/signin_screen.dart';
import 'package:tamang_food_service/screens/widget/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void createAccount() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    bool isValidEmail(String email) {
      // Regular expression for validating an email
      String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      RegExp regex = RegExp(pattern);
      return regex.hasMatch(email);
    }

    if (name == "" || email == "" || password == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(" Please fill all the details"),
        ),
      );
    } else if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(" Please enter a valid email address!"),
        ),
      );
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.pop(
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
                    const SizedBox(width: 135),
                    Text(
                      'Sign Up',
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
                  'Create Account ',
                  style: GoogleFonts.poppins(
                    fontSize: 35,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Enter your Name, Email and Password for sign up.\n',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SigninScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.orange.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    suffixIcon: Icon(
                      Icons.check,
                      color: Color(0xFFEEA734),
                    ),
                    label: Text(
                      'FULL NAME',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
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
                const SizedBox(height: 25),
                custom_button(
                  onpressed: () {
                    createAccount();
                  },
                  buttonText: 'SIGN UP ',
                  fontsize: 19,
                ),
                const SizedBox(height: 20),
                Text(
                  'By Signing up you agree to our Terms Conditions & Privacy Policy.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7),
                  ),
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
