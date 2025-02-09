import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamang_food_service/database.dart';
import 'package:tamang_food_service/screens/forgetpassword_screen.dart';
import 'package:tamang_food_service/screens/homepage_screen.dart';
import 'package:tamang_food_service/screens/signup_screen.dart';
import 'package:tamang_food_service/screens/widget/custom_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String password = "";
  String email = "";
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
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (result.user != null) {
          // Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePageScreen(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } on FirebaseException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("No User Found for that Email"),
            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Wrong Password"),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("An unexpected error occurred: $e"),
          ),
        );
      }
    }
  }

  void login() async {
    try {
      // Completely disconnect the previously signed-in Google account
      await GoogleSignIn()
          .disconnect()
          .catchError((_) {}); // Safely handle if no user is signed in
      await GoogleSignIn().signOut(); // Ensure sign-out is also called

      // Start Google Sign-In process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // After successful Firebase sign-in
      if (result.user != null) {
        String userId = result.user!.uid;

        // Check if the user exists in Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection(
                "User") // Replace "User" with your Firestore collection name
            .doc(userId)
            .get();

        if (userDoc.exists) {
          // User exists in Firestore, navigate to Home Screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePageScreen(),
            ),
          );
        } else {
          // User doesn't exist in Firestore, sign them out
          await FirebaseAuth.instance.signOut();
          await GoogleSignIn().signOut();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("No account found. Please sign up first."),
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SignUpScreen(),
            ),
          );
        }
      }
    } catch (e) {
      // Handle errors (e.g., network issues, authentication failure)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error during login: $e"),
        ),
      );
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30), // Adjust the radius as needed
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30), // Adjust the radius as needed
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
                    if (emailController.text != "" &&
                        passwordController.text != "") {
                      setState(() {
                        email = emailController.text;
                        password = passwordController.text;
                      });
                    }
                    signin();
                  },
                  buttonText: 'SIGN IN ',
                  fontsize: 19,
                ),

                const SizedBox(height: 40),
                Text(
                  'or Login With',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                // Image.asset('assets/Social accounts.png'),
                const SizedBox(height: 30),
                Row(
                  mainAxisSize:
                      MainAxisSize.max, // Adjust size based on content
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        login();
                      },
                      child: Image.asset(
                        'assets/google.png',
                        width: 48, // Set image width
                        height: 48, // Set image height
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/applelogo.png',
                        width: 50, // Set image width
                        height: 50, // Set image height
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
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
                      child: const Text(
                        'Create new account',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 246, 174, 30)),
                      ),
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
