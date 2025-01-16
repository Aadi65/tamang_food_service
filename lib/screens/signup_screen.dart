import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tamang_food_service/database.dart';
import 'package:tamang_food_service/screens/homepage_screen.dart';
import 'package:tamang_food_service/screens/phoneNumberScreen.dart';
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

  String email = "";
  String name = "";
  String password = "";

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
          content: Text("Please fill all the details"),
        ),
      );
    } else if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email address!"),
        ),
      );
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Phonenumberscreen(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("This email is already registered"),
            ),
          );
        } else if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("The password is too weak"),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error"),
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
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? userdetails = result.user;

      if (result.user != null) {
        // Check if the user exists in Firestore
        String userId = result.user!.uid;

        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection(
                "User") // Replace "User" with your Firestore collection name
            .doc(userId)
            .get();

        if (userDoc.exists) {
          // User exists in Firestore
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("This account is already registered"),
            ),
          );
        } else if (result.user != null) {
          // User doesn't exist in Firestore, sign them out
          Map<String, dynamic> userInfoMap = {
            "email": userdetails!.email,
            "name": userdetails.displayName,
            "imgUrl": userdetails.photoURL,
            "id": userdetails.uid,
            "phoneNumber": userdetails.phoneNumber,
          };
          await DatabaseMethods()
              .addUser(userdetails.uid, userInfoMap)
              .then((value) {});
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Phonenumberscreen(),
            ),
          );
        }
      }
    } catch (e) {
      // Handle errors (e.g., network issues, authentication failure)
      print("Error during login: $e");
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8), // Adjust the radius as needed
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
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
                        Radius.circular(8), // Adjust the radius as needed
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
                        Radius.circular(8), // Adjust the radius as needed
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                custom_button(
                  onpressed: () {
                    if (nameController.text != "" &&
                        emailController.text != "" &&
                        passwordController.text != "") {
                      setState(() {
                        email = emailController.text;
                        name = nameController.text;
                        password = passwordController.text;
                      });
                    }
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
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Or',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                        width: 48,
                        height: 48,
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/applelogo.png',
                        width: 50,
                        height: 50,
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
