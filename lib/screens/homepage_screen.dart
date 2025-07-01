import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tamang_food_service/screens/FeaturedPartnersScreen.dart';
import 'package:tamang_food_service/screens/signin_screen.dart';
import 'package:tamang_food_service/screens/widget/DeliveryLocationHeader.dart';
import 'package:tamang_food_service/screens/widget/location_banner.dart';
import 'package:tamang_food_service/screens/widget/partner_item.dart';
import 'package:tamang_food_service/screens/widget/restaurant_card.dart';
import 'package:tamang_food_service/screens/widget/restaurant_tile.dart';
import 'package:tamang_food_service/screens/widget/section_title.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});
  @override
// ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageScreen> {
  String _locationMessage = "Fetching location...";

  void signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SigninScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkAndRequestLocationPermission();
    });
  }

  Future<void> _checkAndRequestLocationPermission() async {
    final location = await LocationService.getLocation(context);
    if (location != null && mounted) {
      setState(() {
        _locationMessage = location;
      });
    } else {
      setState(() {
        _locationMessage = "Location not available";
      });
    }
  }

  final List<String> imagePaths = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: LocationBanner(location: _locationMessage),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    autoPlayInterval: const Duration(seconds: 3),
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                  items: imagePaths.map((imagePath) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 15),
                Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: imagePaths.length,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Colors.black,
                      dotColor: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SectionTitle(
                  title: 'Featured Partners',
                  trailingText: 'See all',
                  onTrailingTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const FeaturedPartnersScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildPartnerItem('assets/aa.png'),
                      const SizedBox(width: 16),
                      buildPartnerItem('assets/ab.png'),
                      const SizedBox(width: 16),
                      buildPartnerItem('assets/ac.png'),
                      const SizedBox(width: 16),
                      buildPartnerItem('assets/ad.png'),
                      const SizedBox(width: 16),
                      buildPartnerItem('assets/aa.png'),
                      const SizedBox(width: 16),
                      buildPartnerItem('assets/ab.png'),
                      const SizedBox(width: 16),
                      buildPartnerItem('assets/ac.png'),
                      const SizedBox(width: 16),
                      buildPartnerItem('assets/ad.png'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 185,
                  width: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/Banner.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const SectionTitle(
                  title: 'Best Picks Restaurants',
                  trailingText: 'See all',
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildRestaurantCard('McDonald\'s',
                          'Hay street, Perth City', 'assets/aa.png'),
                      const SizedBox(width: 16),
                      buildRestaurantCard('The Halal Guys', 'Hay street, Perth',
                          'assets/ab.png'),
                      const SizedBox(width: 16),
                      buildRestaurantCard('McDonald\'s',
                          'Hay street, Perth City', 'assets/ac.png'),
                      const SizedBox(width: 16),
                      buildRestaurantCard('The Halal Guys', 'Hay street, Perth',
                          'assets/ad.png'),
                      const SizedBox(width: 16),
                      buildRestaurantCard('McDonald\'s',
                          'Hay street, Perth City', 'assets/aa.png'),
                      const SizedBox(width: 16),
                      buildRestaurantCard('The Halal Guys', 'Hay street, Perth',
                          'assets/ab.png'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const SectionTitle(
                  title: 'All Restaurants',
                  trailingText: 'See all',
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    buildRestaurantTile('McDonald\'s',
                        '\$\$  Chinese  American   Demos', 'assets/22.png'),
                    buildRestaurantTile('Cafe Brichor\'s',
                        '\$\$  Chinese  American   Demos', 'assets/23.png'),
                    buildRestaurantTile('McDonald\'s',
                        '\$\$  Chinese  American   Demos', 'assets/22.png'),
                    buildRestaurantTile('Cafe Brichor\'s',
                        '\$\$  Chinese  American   Demos', 'assets/23.png'),
                    buildRestaurantTile('McDonald\'s',
                        '\$\$  Chinese  American   Demos', 'assets/22.png'),
                    buildRestaurantTile('Cafe Brichor\'s',
                        '\$\$  Chinese  American   Demos', 'assets/23.png'),
                    buildRestaurantTile('McDonald\'s',
                        '\$\$  Chinese  American   Demos', 'assets/22.png'),
                    buildRestaurantTile('Cafe Brichor\'s',
                        '\$\$  Chinese  American   Demos', 'assets/23.png'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
