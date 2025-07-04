import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamang_food_service/screens/authentication/forgetpassword_screen.dart';
import 'package:tamang_food_service/screens/custom_widget/custom_button.dart';

class ForgetPasswordScreen2 extends StatelessWidget {
  const ForgetPasswordScreen2({super.key});

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
                'Reset email sent ',
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'We have sent a instructions email to sajin tamang@figma.com.',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 25),
              custom_button(
                onpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgetPasswordScreen(),
                    ),
                  );
                },
                buttonText: 'SEND AGAIN',
                fontsize: 19,
              ),
              const SizedBox(height: 123),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image.asset('assets/Open Doodles.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
