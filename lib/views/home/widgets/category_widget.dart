import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/category_controller.dart';
import 'package:food_delivery_app/models/categories_model.dart';
import 'package:food_delivery_app/views/categories/all_categories.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CategoryWidget extends StatelessWidget {
    CategoryWidget({
    super.key,
    required this.category,
  });

  CategoriesModel category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return GestureDetector(
      onTap: () {
        if(controller.categoryValue == category.id){
          controller.updateCategory = '';
          controller.updateTitle = '';
        }
        else if(category.value == 'more'){
          Get.to(
            ()=> const AllCategories(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 900)
          );
        }
        else{
          controller.updateCategory = category.id;
          controller.updateTitle = category.title;
        }
      },
      child: Obx(() => Container(
        width: width*0.19,
        margin: EdgeInsets.only(left: 5.w),
        padding: EdgeInsets.only(top: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: controller.categoryValue == category.id ? kSecondary : kOffWhite,
            width: 0.5.w
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 35.h,
              child: Image.network(
                category.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
      
            CustomText(
              text: category.title, 
              style: appStyle(12, kDark, FontWeight.normal)
            )
          ],
        ),
      ),),       
    );
  }
}