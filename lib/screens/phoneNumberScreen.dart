import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tamang_food_service/screens/otpscreen.dart';
import 'package:tamang_food_service/screens/widget/custom_button.dart';
//import 'package:google_fonts/google_fonts.dart';

class Phonenumberscreen extends StatefulWidget {
  const Phonenumberscreen({super.key});
  @override
// ignore: library_private_types_in_public_api
  _Phonenumberstate createState() => _Phonenumberstate();
}

class _Phonenumberstate extends State<Phonenumberscreen> {
  TextEditingController phoneController = TextEditingController();
  String phone = "";
  void createAccount() async {
    String phone = phoneController.text.trim();
    if (phone == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all the details"),
        ),
      );
    } else {
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91' + phoneController.text,
          verificationCompleted: (PhoneAuthCredential credential) async {
            // Automatically sign in
            await FirebaseAuth.instance.signInWithCredential(credential);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Phone number automatically verified")),
            );
          },
          verificationFailed: (FirebaseAuthException e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("verification failed: ${e.message}"),
              ),
            );
            print("Verification failed: ${e.code} - ${e.message}");
          },
          codeSent: (String vid, int? token) {
            setState(() {});
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Otpscreen(
                  vid: vid,
                  phoneNumber: phone,
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (vid) {},
          timeout: const Duration(seconds: 60),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("This email is already registered"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  const SizedBox(width: 20),
                  Text(
                    'Phone Number Verification',
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
                'Get started with Foodly',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Enter your phone number',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  color: Colors.black.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefix: Text("+91"),
                  prefixIcon: Icon(Icons.phone),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  suffixIcon: Icon(
                    Icons.check,
                    color: Color(0xFFEEA734),
                  ),
                  label: Text(
                    'ENTER PHONE NUMBER',
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
              const SizedBox(height: 24),
              custom_button(
                onpressed: createAccount,
                buttonText: 'Verify',
                fontsize: 19,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
