import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tamang_food_service/database/database.dart';
import 'package:tamang_food_service/screens/authentication/phoneNumberScreen.dart';
import 'package:tamang_food_service/screens/authentication/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isChecked = false;
  bool _obscurePassword = true;
  bool _isEmailValid = false;
  String? _emailError;

  // Email format validation
  bool _validateEmail(String email) {
    final pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    return RegExp(pattern).hasMatch(email);
  }

  // Email + Password Sign Up
  void createAccount() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
      return;
    }

    if (!_validateEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email address!")),
      );
      return;
    }

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
          const SnackBar(content: Text("This email is already registered")),
        );
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("The password is too weak")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Firebase Error: ${e.message}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unexpected error: $e")),
      );
    }
  }

  // Google Sign-In
  void login() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut(); // force fresh login
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? userdetails = result.user;

      if (userdetails != null) {
        String userId = userdetails.uid;

        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("User")
            .doc(userId)
            .get();

        if (userDoc.exists) {
          // 🔴 Already registered
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("This account is already registered")),
          );
          return;
        } else {
          // 🟢 New user
          Map<String, dynamic> userInfoMap = {
            "email": userdetails.email,
            "name": userdetails.displayName,
            "imgUrl": userdetails.photoURL,
            "id": userdetails.uid,
            "phoneNumber": userdetails.phoneNumber,
          };

          await DatabaseMethods()
              .addUser(userdetails.uid, userInfoMap)
              .then((value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Phonenumberscreen(),
              ),
            );
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 140),
                Text(
                  'Sign Up',
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
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
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SigninScreen(),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 246, 174, 30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Full Name
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    suffixIcon: Icon(Icons.person, color: Color(0xFFEEA734)),
                    label: Text(
                      'FULL NAME',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Email
                TextField(
                  controller: emailController,
                  onChanged: (value) {
                    setState(() {
                      _isEmailValid = _validateEmail(value);
                      _emailError = value.isEmpty || _isEmailValid
                          ? null
                          : "Invalid email format";
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    suffixIcon: Icon(
                      Icons.check,
                      color: _isEmailValid
                          ? Colors.green
                          : const Color(0xFFEEA734),
                    ),
                    label: const Text(
                      'EMAIL ADDRESS',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    errorText: _emailError,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Password
                TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xFFEEA734),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    label: const Text(
                      'PASSWORD',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Terms & Conditions Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        'By Signing up you agree to our Terms Conditions & Privacy Policy.',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // Sign Up Button
                Material(
                  color: const Color(0xFFFBC02D),
                  borderRadius: BorderRadius.circular(40),
                  child: InkWell(
                    onTap: isChecked ? createAccount : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 115, vertical: 20),
                      child: const Center(
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                Text(
                  'Or',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: login,
                      child: Image.asset(
                        'assets/google.png',
                        width: 48,
                        height: 48,
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        // implement Apple login if needed
                      },
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
