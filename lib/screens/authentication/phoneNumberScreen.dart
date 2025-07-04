import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamang_food_service/screens/authentication/otpscreen.dart';
import 'package:tamang_food_service/screens/custom_widget/custom_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Phonenumberscreen extends StatefulWidget {
  const Phonenumberscreen({super.key});

  @override
  _Phonenumberstate createState() => _Phonenumberstate();
}

class _Phonenumberstate extends State<Phonenumberscreen> {
  TextEditingController phoneController = TextEditingController();

  void createAccount() async {
    String phone = phoneController.text.trim();
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all the details"),
        ),
      );
      return;
    }

    print("Phone number submitted for verification: $phone");

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Phone number automatically verified")),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Verification failed: ${e.message}"),
            ),
          );
          print("Verification failed: ${e.code} - ${e.message}");
        },
        codeSent: (String vid, int? token) {
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
        timeout: const Duration(seconds: 15),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An unexpected error occurred: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Phone Number Verification',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
                    'Add your phone number. We’ll send you a verification code so we know you’re real.',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  IntlPhoneField(
                    initialCountryCode: 'IN',
                    onChanged: (value) {
                      phoneController.text = value.completeNumber;
                      print("Phone Number ---> ${value.completeNumber}");
                    },
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      hintText: "Enter Phone Number",
                      labelText: "Phone No:",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
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
                  const SizedBox(height: 25),
                  Text(
                    'By providing my phone number, I hereby agree and accept the Terms of Service and Privacy Policy.',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
