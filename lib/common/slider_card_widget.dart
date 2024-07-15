// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AdvertisementCarousel extends StatefulWidget {
  const AdvertisementCarousel({super.key});

  @override
  _AdvertisementCarouselState createState() => _AdvertisementCarouselState();
}

class _AdvertisementCarouselState extends State<AdvertisementCarousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Column(
        children: [
          SizedBox(
            height: 115.h,
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: advertisementImgList.length,
              itemBuilder: (context, index, realIndex) {
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
              options: CarouselOptions(
                initialPage: 0,
                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
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
