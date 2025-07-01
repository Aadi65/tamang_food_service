import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tamang_food_service/screens/widget/BottomNavProvider.dart';

import 'AccountSettingsScreen.dart';
import 'OrderScreen.dart';
import 'SearchScreen.dart';
import 'homepage_screen.dart';

class MainLayoutWithGNav extends StatelessWidget {
  final int initialIndex;

  MainLayoutWithGNav({super.key, this.initialIndex = 0});

  final List<Widget> screens = [
    HomePageScreen(),
    SearchScreen(),
    Orderscreen(),
    AccountSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, navProvider, _) {
        // Apply initialIndex only once
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!navProvider.hasInitialized) {
            navProvider.setIndex(initialIndex);
            navProvider.hasInitialized = true;
          }
        });

        return Scaffold(
          body: IndexedStack(
            index: navProvider.currentIndex,
            children: screens,
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: GNav(
              backgroundColor: Colors.white,
              color: Colors.black,
              activeColor: Colors.white,
              tabBackgroundColor: const Color(0xFFFBC02D),
              gap: 8,
              selectedIndex: navProvider.currentIndex,
              onTabChange: (index) => navProvider.setIndex(index),
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.search, text: 'Search'),
                GButton(icon: Icons.shopping_cart, text: 'Order'),
                GButton(icon: Icons.person_outline, text: 'Profile'),
              ],
            ),
          ),
        );
      },
    );
  }
}
