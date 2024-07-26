import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/login_response.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key, this.user});

  final LoginResponse? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.07,
      width: width,
      color: kWhite,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: kSecondary,
                  backgroundImage: NetworkImage(
                    user!.profile ??
                    "https://as2.ftcdn.net/v2/jpg/03/49/49/79/1000_F_349497933_Ly4im8BDmHLaLzgyKg2f2yZOvJjBtlw5.jpg"
                  ),
                ),
            
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h, left: 8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: user!.username ?? "User Name",
                        style: appStyle(13, kGray, FontWeight.w500),
                      ),
            
                      SizedBox(
                        width: width * 0.65,
                        child: Text(
                          user!.email ?? "samarth008@gmail.com",
                          style: appStyle(11, kGrayLight, FontWeight.normal,),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
        
              ],
            ),
            
            GestureDetector(
              onTap: (){
                // Redirect to Settings //
              },
              child: Icon(
                AntDesign.edit,
                size: 18.h,
              ),
            ),     
          ],
        ),
      ),  
    );  
  }
}