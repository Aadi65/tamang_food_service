import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamang_food_service/screens/authentication/signin_screen.dart';
import 'package:tamang_food_service/screens/custom_widget/custom_button.dart';
import 'walkthrough_contents.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<WalkthroughScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Row(
              children: [
                const SizedBox(width: 20),
                Image.asset('assets/g12.png'),
                const SizedBox(width: 20),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(),
                          width: double.infinity,
                          child: Image.asset(
                            fit: BoxFit.cover,
                            contents[i].image,
                          ),
                        ),
                        const SizedBox(height: 35),
                        Text(
                          contents[i].title,
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          textAlign: TextAlign.center,
                          contents[i].description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: custom_button(
                onpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SigninScreen(),
                    ),
                  );
                },
                buttonText: 'Get Started',
                fontsize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
    );
  }
}
