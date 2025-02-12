import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tamang_food_service/screens/FeaturedPartnersScreen.dart';
import 'package:tamang_food_service/screens/MenuScreen.dart';
import 'package:tamang_food_service/screens/SearchScreen.dart';
import 'package:tamang_food_service/screens/signin_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tamang_food_service/screens/widget/HomeBottomBar.dart';
//import 'package:google_fonts/google_fonts.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});
  @override
// ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageScreen> {
  String _locationMessage = "";

  void signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    //Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SigninScreen(),
      ),
    );
  }

  void afterLogin() {
    //After the user logs in, check for location permissions
    _checkAndRequestLocationPermission();
  }

  @override
  void initState() {
    super.initState();
    // Check location permission on widget initialization

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndRequestLocationPermission();
    });
  }

  Future<void> _checkAndRequestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationServiceDialog();
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showPermissionDeniedDialog();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showPermissionDeniedForeverDialog();
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
          // ignore: deprecated_member_use
          desiredAccuracy:
              LocationAccuracy.high); // ignore: deprecated_member_use
      // Get address from coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _locationMessage =
              "${place.name}, ${place.locality}, ${place.country}"; // Address
        });
      } else {
        setState(() {
          _locationMessage = "Address not found.";
        });
      }
      // print('User location: ${position.latitude}, ${position.longitude}');
    }
  }

  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enable Location Services'),
        content:
            const Text('Please enable location services to use this feature.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Geolocator.openLocationSettings();
              Navigator.pop(context);
            },
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Denied'),
        content: const Text(
            'We need location permission to provide location-based services.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedForeverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Denied Forever'),
        content: const Text(
            'Please enable location permission from the app settings.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Geolocator.openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  int _selectedIndex = 0; // Track the selected index
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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "DELIVERY TO",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFFBC02D),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _locationMessage,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                      //setState(() {
                      //activeIndex = index;
                      //});
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
                Row(
                  children: [
                    Text(
                      'Featured Partners',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 110),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeaturedPartnersScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 246, 174, 30),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildPartnerItem('assets/aa.png'),
                      const SizedBox(width: 16),
                      _buildPartnerItem('assets/ab.png'),
                      const SizedBox(width: 16),
                      _buildPartnerItem('assets/ac.png'),
                      const SizedBox(width: 16),
                      _buildPartnerItem('assets/ad.png'),
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
                Row(
                  children: [
                    Text(
                      'Best Picks Restaurants',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 50),
                    const Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFFBC02D),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildRestaurantCard('McDonald\'s',
                          'Hay street, Perth City', 'assets/aa.png'),
                      const SizedBox(width: 16),
                      _buildRestaurantCard('The Halal Guys',
                          'Hay street, Perth', 'assets/ab.png'),
                      const SizedBox(width: 16),
                      _buildRestaurantCard('McDonald\'s',
                          'Hay street, Perth City', 'assets/ac.png'),
                      const SizedBox(width: 16),
                      _buildRestaurantCard('The Halal Guys',
                          'Hay street, Perth', 'assets/ad.png'),
                      const SizedBox(width: 16),
                      _buildRestaurantCard('McDonald\'s',
                          'Hay street, Perth City', 'assets/aa.png'),
                      const SizedBox(width: 16),
                      _buildRestaurantCard('The Halal Guys',
                          'Hay street, Perth', 'assets/ab.png'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'All Restaurants',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 135),
                    const Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFFBC02D),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    _buildRestaurantTile('McDonald\'s',
                        '\$\$  Chinese  American   Demos', 'assets/22.png'),
                    _buildRestaurantTile('Cafe Brichor\'s',
                        '\$\$  Chinese  American   Demos', 'assets/23.png'),
                    _buildRestaurantTile('McDonald\'s',
                        '\$\$  Chinese  American   Demos', 'assets/22.png'),
                    _buildRestaurantTile('Cafe Brichor\'s',
                        '\$\$  Chinese  American   Demos', 'assets/23.png'),
                    _buildRestaurantTile('McDonald\'s',
                        '\$\$  Chinese  American   Demos', 'assets/22.png'),
                    _buildRestaurantTile('Cafe Brichor\'s',
                        '\$\$  Chinese  American   Demos', 'assets/23.png'),
                    _buildRestaurantTile('McDonald\'s',
                        '\$\$  Chinese  American   Demos', 'assets/22.png'),
                    _buildRestaurantTile('Cafe Brichor\'s',
                        '\$\$  Chinese  American   Demos', 'assets/23.png'),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: HomebottomBar(
          selectedIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

// Helper method to build partner item
  Widget _buildPartnerItem(String imagePath) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Future.delayed(Duration.zero, () {
                if (mounted) {
                  setState(() {
                    // Some state change here
                  });
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imagePath,
                  width: 200,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Krispy Creme",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "St Georgece Terrace, Perth",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "4.5",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildRestaurantCard(String title, String subtitle, String imagePath) {
  return SizedBox(
    width: 200, // Ensure a consistent width
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text properly
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imagePath,
                width: 200, // Consistent with the container width
                height: 160, // Adjust height to maintain aspect ratio
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            title, // Removed `const`
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle, // Removed `const`
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "4.5",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildRestaurantTile(String title, String subtitle, String imagePath) {
  return SizedBox(
    width: double.infinity, // Take full width
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text properly
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imagePath,
                width: double.infinity, // Full width
                height: 200, // Adjust height to maintain aspect ratio
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "4.5",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
