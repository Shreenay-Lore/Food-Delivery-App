// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AdvertisementCarousel extends StatefulWidget {
  const AdvertisementCarousel({super.key});

  @override
  _AdvertisementCarouselState createState() => _AdvertisementCarouselState();
}

class _AdvertisementCarouselState extends State<AdvertisementCarousel> {
  int activeIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 1);
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      int nextPage = activeIndex + 1;
      if (nextPage >= advertisementImgList.length) {
        nextPage = 0;
      }
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Column(
        children: [
          SizedBox(
            height: 115.h,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  activeIndex = index;
                });
              },
              itemCount: advertisementImgList.length,
              itemBuilder: (context, index) {
                final image = advertisementImgList[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.h),
                    child: Image.network(
                      image,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8.h),
          buildIndicator(),
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: advertisementImgList.length,
        effect: WormEffect(
          dotHeight: 8.h,
          dotWidth: 8.h,
          activeDotColor: kDark,
          dotColor: kGrayLight,
        ),
      );
}

