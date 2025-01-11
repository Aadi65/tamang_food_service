// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tamang_food_service/screens/signup_screen.dart';
// import 'package:tamang_food_service/wrapper.dart';
// //import 'package:tamang_food_service/screens/widget/custom_button.dart';
// //import 'package:tamang_food_service/wrapper.dart';

// class Verifyscreen extends StatefulWidget {
//   const Verifyscreen({super.key});

//   @override
//   State<Verifyscreen> createState() => _VerifyscreenState();
// }

// class _VerifyscreenState extends State<Verifyscreen> {
//   @override
//   void initState() {
//     sendverifylink();
//     super.initState();
//   }

//   sendverifylink() async {
//     final user = FirebaseAuth.instance.currentUser!;
//     await user.sendEmailVerification().then((value) {
//       const SnackBar(
//         content: Text("Verification email sent! Please check your inbox."),
//       );
//     });
//   }

//   reload() async {
//     await FirebaseAuth.instance.currentUser!.reload().then((value) {
//       Navigator.pop(
//         context,
//         MaterialPageRoute(builder: (context) => const Wrapper()),
//         // (route) => false,
//       );
//     });
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.pop(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const SignUpScreen()),
//                       );
//                     },
//                     child: const Icon(
//                       Icons.arrow_back_ios_new,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(width: 80),
//                   Text(
//                     'Verification',
//                     style: GoogleFonts.poppins(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 250),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Text(
//                   'Open your email and click on the link provided to verify email & reload this page',
//                   style: GoogleFonts.poppins(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w300,
//                     color: Colors.black.withOpacity(0.5),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 300),
//               Center(
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     reload();
//                   },
//                   child: const Icon(Icons.restart_alt_rounded),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
