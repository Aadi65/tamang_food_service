import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? trailingText;
  final VoidCallback? onTrailingTap;

  const SectionTitle({
    super.key,
    required this.title,
    this.trailingText,
    this.onTrailingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        if (trailingText != null)
          InkWell(
            onTap: onTrailingTap,
            child: Text(
              trailingText!,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFFFBC02D),
              ),
            ),
          ),
      ],
    );
  }
}
