import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tamang_food_service/screens/RestaurantMenu.dart';
import 'package:tamang_food_service/screens/homepage_screen.dart';
import 'package:tamang_food_service/screens/widget/BottomNavProvider.dart';

class FeaturedPartnersScreen extends StatefulWidget {
  const FeaturedPartnersScreen({super.key});

  @override
  State<FeaturedPartnersScreen> createState() => _FeaturedPartnersScreenState();
}

class _FeaturedPartnersScreenState extends State<FeaturedPartnersScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to HomePageScreen instead of closing the app
        Navigator.pop(context);
        Provider.of<BottomNavProvider>(context, listen: false).setIndex(0);
        return false; // Prevent default back behavior (app closing)
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context); // Goes back if possible
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePageScreen()),
                );
              }
            },
          ),
          title: Text(
            "Featured Partners",
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: false,
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: partners.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RestaurantMenu(partner: partners[index]),
                    ),
                  );
                },
                child: PartnerCard(
                  image: partners[index]['image']!,
                  title: partners[index]['title']!,
                  cuisine: partners[index]['cuisine']!,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class PartnerCard extends StatelessWidget {
  final String image;
  final String title;
  final String cuisine;

  PartnerCard({
    required this.image,
    required this.title,
    required this.cuisine,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        // Wrap Column inside a Container
        color: Colors.white, // Set background color to white
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "25 min",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.money_off,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "Free",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  "4.5",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    cuisine,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> partners = [
  {
    "image": "assets/Tacos.png",
    "title": "Tacos Nanchas",
    "cuisine": "Chinese  American"
  },
  {
    "image": "assets/Macd.png",
    "title": "McDonald's",
    "cuisine": "Chinese  American"
  },
  {
    "image": "assets/kfc.png",
    "title": "KFC Foods",
    "cuisine": "Chinese  American"
  },
  {
    "image": "assets/CoffeeShop.png",
    "title": "Coffee Shop",
    "cuisine": "Chinese  American"
  },
  {
    "image": "assets/Cafe.png",
    "title": "TMX Cafe",
    "cuisine": "Chinese  American"
  },
  {
    "image": "assets/Tacos.png",
    "title": "Tacos Nanchas",
    "cuisine": "Chinese  American"
  },
  {
    "image": "assets/Macd.png",
    "title": "McDonald's",
    "cuisine": "Chinese  American"
  },
  {
    "image": "assets/kfc.png",
    "title": "KFC Foods",
    "cuisine": "Chinese  American"
  },
  {
    "image": "assets/CoffeeShop.png",
    "title": "Coffee Shop",
    "cuisine": "Chinese - American"
  },
  {
    "image": "assets/Cafe.png",
    "title": "TMX Cafe",
    "cuisine": "Chinese  American"
  },
  {
    "image": "assets/Macd.png",
    "title": "McDonald's",
    "cuisine": "Chinese  American"
  },
  {
    "image": "assets/Tacos.png",
    "title": "Tacos Nanchas",
    "cuisine": "Chinese  American"
  },
];
