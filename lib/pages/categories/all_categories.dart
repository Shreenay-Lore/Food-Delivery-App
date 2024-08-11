import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/categories_model.dart';
import 'package:food_delivery_app/pages/categories/controller/category_controller.dart';
import 'package:food_delivery_app/pages/categories/widgets/header_widget.dart';
import 'package:food_delivery_app/pages/categories/widgets/intro_text.dart';
import 'package:get/get.dart';
import 'widgets/category_tile.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.put(CategoryController());

    return Scaffold(
      backgroundColor: kWhite,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const FoodsListShimmer();
        } else {
          return buildContent(controller.allCategories);
        }
      }),
      
    );
  }

  Widget buildContent(List<CategoriesModel>? categories) {
    return Column(
      children: [
        HeaderWidget(
          imageUrl: "https://img.pikbest.com/wp/202405/fast-food-restaurant-cartoon-3d-rendered-for-a_9829583.jpg!bw700",
          height: 130.h,
        ),

        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            itemCount: (categories?.length ?? 0) + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                 return const IntroTextWidget(
                  title: "Discover All Categories!",
                  subtitle: "From our kitchen to your table, enjoy every delicious moment.",
                );
              }
              final category = categories![index - 1];
              return CategoryTile(category: category);
            },
          ),
        ),
      ],
    );
  }

}
