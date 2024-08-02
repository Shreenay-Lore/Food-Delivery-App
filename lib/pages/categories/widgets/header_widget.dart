import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatelessWidget {
  final String imageUrl;
  final double height;

  const HeaderWidget({
    Key? key,
    required this.imageUrl,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: height,
          color: kLightWhite,
          child: CachedNetworkImage(
            fit: BoxFit.fitWidth,
            imageUrl: imageUrl,
          ),
        ),
        Positioned(
          top: 45.h,
          left: 14,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Ionicons.arrow_back_circle,
              color: Colors.white,
              size: 32.h,
            ),
          ),
        ),
      ],
    );
  }
}
