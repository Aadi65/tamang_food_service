import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class custom_button extends StatelessWidget {
  custom_button({
    required this.onpressed,
    required this.buttonText,
    required this.fontsize,
    super.key,
    Null Function()? onPressed,
  });
  VoidCallback onpressed;
  String buttonText;
  double fontsize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Material(
        color: Color(0xFFFBC02D),
        borderRadius: BorderRadius.circular(40),
        child: InkWell(
          onTap: onpressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 115, vertical: 20),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontsize,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
