import 'package:flutter/material.dart';

class LocationBanner extends StatelessWidget {
  final String location;

  const LocationBanner({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            "DELIVERY TO",
            style: TextStyle(fontSize: 14, color: Color(0xFFFBC02D)),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                location,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
