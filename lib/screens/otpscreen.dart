import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:tamang_food_service/screens/MainLayoutWithGNav.dart';
import 'package:tamang_food_service/screens/widget/custom_button.dart';

class Otpscreen extends StatefulWidget {
  final String vid;
  final String phoneNumber;

  const Otpscreen({super.key, required this.vid, required this.phoneNumber});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  var code = '';

  Future<void> signIn() async {
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 6-digit OTP.")),
      );
      return;
    }

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.vid,
      smsCode: code,
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP verified successfully!")),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainLayoutWithGNav(initialIndex: 0),
          ),
          (Route<dynamic> route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? "An unknown error occurred.";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $errorMessage")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unexpected error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ Ensure background is set
      body: SafeArea(
        child: SingleChildScrollView(
          // ✅ Scrollable in case of keyboard
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
                    const SizedBox(width: 105),
                    Text(
                      'Verify OTP',
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
                  'Enter OTP',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Enter the 6-digit code sent to ${widget.phoneNumber}',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Pinput(
                  length: 6,
                  onChanged: (value) {
                    setState(() {
                      code = value;
                    });
                  },
                  defaultPinTheme: PinTheme(
                    width: 50,
                    height: 50,
                    textStyle: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                custom_button(
                  onpressed: signIn,
                  buttonText: 'VERIFY OTP',
                  fontsize: 19,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
