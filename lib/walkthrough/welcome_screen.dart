import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamang_food_service/walkthrough/walkthrough_screen.dart';
import 'package:tamang_food_service/screens/custom_widget/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset('assets/Circle Background.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Row(
                  children: [
                    Image.asset('assets/g12.png'),
                    const SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          maxLines: 2,
                          textAlign: TextAlign.justify,
                          'Tamang',
                          style: GoogleFonts.poppins(
                            fontSize: 37,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          maxLines: 2,
                          textAlign: TextAlign.justify,
                          'FoodService',
                          style: GoogleFonts.poppins(
                            fontSize: 37,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 68),
                Image.asset('assets/Illustration.png'),
                const SizedBox(height: 40),
                Text(
                  'Welcome',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  textAlign: TextAlign.center,
                  "It’s a pleasure to meet you. We are excited that you’re here so let’s get started!",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 80),
                custom_button(
                  onpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WalkthroughScreen(),
                      ),
                    );
                  },
                  buttonText: 'Get Started',
                  fontsize: 22,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
