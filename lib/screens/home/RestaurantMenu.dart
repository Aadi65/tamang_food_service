import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamang_food_service/screens/custom_widget/fooditem.dart';

class RestaurantMenu extends StatefulWidget {
  final Map<String, String> partner;

  const RestaurantMenu({super.key, required this.partner});

  @override
  State<RestaurantMenu> createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState(); // ✅ First call super
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // ✅ go back to FeaturedPartnersScreen
          },
        ),
      ),
      body: SafeArea(
        // Ensures content starts after the notch
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                widget.partner['image']!,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.partner['title']!,
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          widget.partner['cuisine']!,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Deshi Food',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Featured Items',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFeaturedItem(
                              'Cookie Sandwich', '\$5', 'assets/bg3.png'),
                          const SizedBox(width: 16),
                          _buildFeaturedItem(
                              'Chow Fun', '\$5', 'assets/bg2.png'),
                          const SizedBox(width: 16),
                          _buildFeaturedItem(
                              'Cookie Sandwich', '\$5', 'assets/bg3.png'),
                          const SizedBox(width: 16),
                          _buildFeaturedItem(
                              'Chow Fun', '\$5', 'assets/bg2.png'),
                          const SizedBox(width: 16),
                          _buildFeaturedItem(
                              'Cookie Sandwich', '\$5', 'assets/bg3.png'),
                          const SizedBox(width: 16),
                          _buildFeaturedItem(
                              'Chow Fun', '\$5', 'assets/bg2.png'),
                          const SizedBox(width: 16),
                          _buildFeaturedItem(
                              'Cookie Sandwich', '\$5', 'assets/bg3.png'),
                          const SizedBox(width: 16),
                          _buildFeaturedItem(
                              'Chow Fun', '\$5', 'assets/bg2.png'),
                          const SizedBox(width: 16),
                          _buildFeaturedItem(
                              'Cookie Sandwich', '\$5', 'assets/bg3.png'),
                          const SizedBox(width: 16),
                          _buildFeaturedItem(
                              'Chow Fun', '\$5', 'assets/bg2.png'),
                        ],
                      ),
                    ),
                    TabBar(
                      dividerColor: Colors.transparent,
                      controller: _tabController,
                      labelColor: const Color(0xFFFBC02D),
                      unselectedLabelColor: Colors.black.withOpacity(0.8),
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xFFFBC02D),
                        ),
                        insets: EdgeInsets.symmetric(horizontal: 5),
                      ),
                      labelStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      // labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                      tabs: const [
                        Tab(text: "Lamb"),
                        Tab(text: "Sea Food"),
                        Tab(text: "Appetizers"),
                        Tab(text: "Dessert"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Most Popular',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const FoodItem(
                      title: 'Cookie Sandwich',
                      description:
                          'Shortbread, chocolate turtle cookies, and red velvet.',
                      price: 'AUD\$10',
                      image: 'assets/food1.png',
                    ),
                    const FoodItem(
                      title: 'Combo Burger',
                      description:
                          'Shortbread, chocolate turtle cookies, and red velvet.',
                      price: 'AUD\$10',
                      image: 'assets/food2.png',
                    ),
                    const FoodItem(
                      title: 'Combo Sandwich',
                      description:
                          'Shortbread, chocolate turtle cookies, and red velvet.',
                      price: 'AUD\$10',
                      image: 'assets/food3.png',
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Sea Foods',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const FoodItem(
                      title: 'Oyster Dish',
                      description:
                          'Shortbread, chocolate turtle cookies, and red velvet.',
                      price: 'AUD\$10',
                      image: 'assets/food4.png',
                    ),
                    const FoodItem(
                      title: 'Oyster On Ice',
                      description:
                          'Shortbread, chocolate turtle cookies, and red velvet.',
                      price: 'AUD\$10',
                      image: 'assets/food5.png',
                    ),
                    const FoodItem(
                      title: 'Oyster On Ice',
                      description:
                          'Shortbread, chocolate turtle cookies, and red velvet.',
                      price: 'AUD\$10',
                      image: 'assets/food6.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedItem(String name, String price, String imagePath) {
    return SizedBox(
      width: 150, // Ensure a consistent width
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
                  height: 150, // Adjust height to maintain aspect ratio
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              name, // Removed `const`
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                price, // Removed `const`
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 30),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chinese",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
