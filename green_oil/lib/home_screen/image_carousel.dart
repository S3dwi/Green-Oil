import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() {
    return _ImageCarouselState();
  }
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0; // Track the current index

  // List of image paths
  final List<String> imageList = [
    'assets/images/recycle-Oil.png',
    'assets/images/recycled-products.png',
    'assets/images/2030-vision.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Carousel items
        CarouselSlider(
          items: imageList.map(
            (imagePath) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ).toList(),
          options: CarouselOptions(
            height: 150,
            aspectRatio: 2.0,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index; // Update the index
              });
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(height: 8),
        // Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () =>
                  _goToSlide(entry.key), // Optional: jump to slide on tap
              child: Container(
                width: _currentIndex == entry.key
                    ? 12.0
                    : 8.0, // Highlight current slide
                height: _currentIndex == entry.key ? 12.0 : 8.0,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 2.5,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Theme.of(context)
                          .colorScheme
                          .primary // Active indicator color
                      : Theme.of(context)
                          .disabledColor, // Inactive indicator color
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Optional function to jump to a specific slide
  void _goToSlide(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
