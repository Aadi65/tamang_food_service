import 'package:flutter/material.dart';

class HomebottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  HomebottomBar({required this.selectedIndex, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.home,
            color: Color(0xFFFBC02D),
            size: 30,
          ),
          Icon(
            Icons.search,
            color: Colors.grey,
            size: 30,
          ),
          Icon(
            Icons.menu,
            color: Colors.grey,
            size: 30,
          ),
          Icon(
            Icons.person,
            color: Colors.grey,
            size: 30,
          ),
        ],
      ),
    );
  }
}
