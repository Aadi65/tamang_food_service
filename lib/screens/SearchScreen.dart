import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SearchPage(); // ✅ Directly return the page
  }
}

class SearchPage extends StatelessWidget {
  final List<Map<String, String>> restaurants = [
    {
      'name': 'The Halal Guys',
      'price': '\$\$',
      'cuisine': 'Chinese',
      "image": "assets/s6.png.png",
    },
    {
      'name': 'Popeyes 1426 Flmst',
      'price': '\$\$',
      'cuisine': 'Chinese',
      "image": "assets/s5.png.png",
    },
    {
      'name': 'Mixt - Yerba Buena',
      'price': '\$\$',
      'cuisine': 'Chinese',
      "image": "assets/s4.png.png",
    },
    {
      'name': 'Split Bread - Russian',
      'price': '\$',
      'cuisine': 'Chinese',
      "image": "assets/s3.png.png",
    },
    {
      'name': 'Split Bread - Russian',
      'price': '\$',
      'cuisine': 'Chinese',
      "image": "assets/s2.png.png",
    },
    {
      'name': 'Split Bread - Russian',
      'price': '\$',
      'cuisine': 'Chinese',
      "image": "assets/s1.png.png",
    },
    // Repeated for demo
    {
      'name': 'The Halal Guys',
      'price': '\$\$',
      'cuisine': 'Chinese',
      "image": "assets/s6.png.png",
    },
    {
      'name': 'Popeyes 1426 Flmst',
      'price': '\$\$',
      'cuisine': 'Chinese',
      "image": "assets/s5.png.png",
    },
    {
      'name': 'Mixt - Yerba Buena',
      'price': '\$\$',
      'cuisine': 'Chinese',
      "image": "assets/s4.png.png",
    },
    {
      'name': 'Split Bread - Russian',
      'price': '\$',
      'cuisine': 'Chinese',
      "image": "assets/s3.png.png",
    },
    {
      'name': 'Split Bread - Russian',
      'price': '\$',
      'cuisine': 'Chinese',
      "image": "assets/s2.png.png",
    },
    {
      'name': 'Split Bread - Russian',
      'price': '\$',
      'cuisine': 'Chinese',
      "image": "assets/s1.png.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Search',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search on Tamang',
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'Top Restaurants',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: restaurants.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return RestaurantCard(restaurant: restaurants[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Map<String, String> restaurant;
  const RestaurantCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              restaurant['image']!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.grey[300]),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          restaurant['name']!,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          '${restaurant['price']} · ${restaurant['cuisine']}',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
