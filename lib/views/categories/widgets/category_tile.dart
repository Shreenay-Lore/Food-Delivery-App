import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/category_controller.dart';
import 'package:food_delivery_app/models/categories_model.dart';
import 'package:food_delivery_app/views/categories/category_page.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CategoryTile extends StatelessWidget {
    CategoryTile({
    super.key,
    required this.category,
  });

  CategoriesModel category;

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.put(CategoryController());   
    
    return ListTile(
      onTap: () {
        controller.updateCategory = category.id;
        controller.updateTitle = category.title;
        Get.to(
          ()=> const CategoryPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 900)
        );
      },
      contentPadding: EdgeInsets.only(left: 12.w, top: 10.h),
      leading: CircleAvatar(
        radius: 18.r,
        backgroundColor: kGrayLight,
        child : Image.network(category.imageUrl, fit: BoxFit.contain,),
      ),
      title: CustomText(
        text: category.title,
        style: appStyle(12, kGray, FontWeight.normal),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded, 
        color: kGray, 
        size: 15.r,
      ),
    );
  }
}