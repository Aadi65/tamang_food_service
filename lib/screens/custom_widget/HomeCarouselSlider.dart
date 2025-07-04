import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeCarouselSlider extends StatelessWidget {
  final List<String> imagePaths;
  final int activeIndex;
  final Function(int) onPageChanged;

  const HomeCarouselSlider({
    super.key,
    required this.imagePaths,
    required this.activeIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            autoPlayInterval: const Duration(seconds: 3),
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) => onPageChanged(index),
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
        const SizedBox(height: 10),
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: imagePaths.length,
          effect: const ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Colors.black,
            dotColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}
