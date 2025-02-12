import 'package:flutter/material.dart';
import 'package:tamang_food_service/screens/AccountSettingsScreen.dart';
import 'package:tamang_food_service/screens/MenuScreen.dart';
import 'package:tamang_food_service/screens/SearchScreen.dart';
import 'package:tamang_food_service/screens/homepage_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomebottomBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  HomebottomBar({required this.selectedIndex, required this.onTap});

  @override
  State<HomebottomBar> createState() => _HomebottomBarState();
}

class _HomebottomBarState extends State<HomebottomBar> {
  int _selectedIndex = 0;

  // // Track the selected index
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildNavItem(context, Icons.home, 0),
          buildNavItem(context, Icons.search, 1),
          buildNavItem(context, Icons.menu, 2),
          buildNavItem(context, Icons.person, 3), // ✅ Profile navigation
        ],
      ),
    );
  }

  Widget buildNavItem(BuildContext context, IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 3) {
          // ✅ Navigate to Profile Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccountSettingsScreen()),
          );
        } else {
          widget.onTap(index); // ✅ Change the tab normally
        }
      },
      child: Icon(
        icon,
        color: widget.selectedIndex == index
            ? const Color(0xFFFBC02D)
            : Colors.grey,
        size: 30,
      ),
    );
  }
}
