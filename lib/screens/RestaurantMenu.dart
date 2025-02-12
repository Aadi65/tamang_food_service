import 'package:flutter/material.dart';

class RestaurantMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.network(
                  'https://pplx-res.cloudinary.com/image/upload/v1739372711/user_uploads/dxHhTPtkFMkwIGE/Screenshot-2025-02-12-203428.jpg',
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.share, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Mayfield Bakery & Cafe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$\$ - Chinese - American - Deshi Food',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const Text('4.2'),
                      const Text(' (700+ ratings)',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.delivery_dining, color: Colors.orange),
                      const Text(' Free Delivery '),
                      const SizedBox(width: 16),
                      const Icon(Icons.timer, color: Colors.orange),
                      const Text(' 25 Minutes'),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade50,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Take Away'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Featured Items',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        _buildFeaturedItem(
                            'Cookie Sandwich', '\$5 - Chinese', ''),
                        _buildFeaturedItem('Chow Fun', '\$5 - Chinese', ''),
                        _buildFeaturedItem(
                            'Dim Sum', '\$5 - Chinese', ''), // Placeholder
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {},
                          child: const Text('All'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('& Lamb'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Seafood'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Appetizers'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Drinks'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Most Populars',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildMenuItem(
                      'Cookie Sandwich',
                      'Shortbread, chocolate turtle cookies, and red velvet.',
                      '\$5 - Chinese',
                      'AU\$10'),
                  _buildMenuItem(
                      'Combo Burger',
                      'Shortbread, chocolate turtle cookies, and red velvet.',
                      '\$5 - Chinese',
                      'AU\$10'),
                  _buildMenuItem(
                      'Combo Sandwich',
                      'Shortbread, chocolate turtle cookies, and red velvet.',
                      '\$5 - Chinese',
                      'AU\$10'),
                  const SizedBox(height: 16),
                  const Text(
                    'Sea Foods',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildMenuItem(
                      'Oyster Dish',
                      'Shortbread, chocolate turtle cookies, and red velvet.',
                      '\$5 - Chinese',
                      'AU\$10'),
                  _buildMenuItem(
                      'Oyster On Ice',
                      'Shortbread, chocolate turtle cookies, and red velvet.',
                      '\$5 - Chinese',
                      'AU\$10'),
                  _buildMenuItem(
                      'Fried Rice on Pot',
                      'Shortbread, chocolate turtle cookies, and red velvet.',
                      '\$5 - Chinese',
                      'AU\$10'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedItem(String name, String description, String price) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://via.placeholder.com/100', // Replace with your image URL
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      String name, String description, String price, String audPrice) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://via.placeholder.com/80', // Replace with your image URL
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  price,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            audPrice,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
