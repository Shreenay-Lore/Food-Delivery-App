import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';

class ProfileTileWidget extends StatelessWidget {
  const ProfileTileWidget({
    super.key, 
    required this.title, 
    required this.icon, 
    this.onTap,
  });

  final String title;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12.r), 
      ),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        onTap: onTap,
        minLeadingWidth: 0,
        leading: Icon(icon , size: 20,),
        title: CustomText(text: title, style: appStyle(11, kGray, FontWeight.normal)),
        trailing: title != "Log out" 
          ? const Icon(
              AntDesign.right,
              size: 16,
            )
          : const SizedBox(),
      ),
    );
  }
}