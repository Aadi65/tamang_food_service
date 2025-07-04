import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Orderscreen extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      "image": "assets/food1.png",
      "name": "McDonald's",
      "description": "Shortbread, chocolate turtle cookies, and red velvet.",
      "price": 10.0
    },
    {
      "image": "assets/food2.png",
      "name": "Uncle Boy's",
      "description": "Shortbread, chocolate turtle cookies, and red velvet.",
      "price": 10.0
    },
    {
      "image": "assets/food3.png",
      "name": "The Halal Guys",
      "description": "Shortbread, chocolate turtle cookies, and red velvet.",
      "price": 10.0
    },
  ];

  double calculateTotalAmount() {
    return orders.fold(0.0, (sum, item) => sum + item['price']);
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = calculateTotalAmount();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Your Orders',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "UPCOMING ORDERS",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  "CLEAR ALL",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Order List (Static size)
            ...orders.map((order) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        order["image"],
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order["name"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order["description"],
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Row(
                            children: const [
                              Text("\$\$  ·  ",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey)),
                              Text("Chinese",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "AUD\$${order["price"].toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            const SizedBox(height: 10),

            // Checkout section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: AUD\$${totalAmount.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // handle checkout
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Checkout",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
