import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/fetch_all_categories.dart';
import 'package:food_delivery_app/models/categories_model.dart';
import 'package:food_delivery_app/views/categories/widgets/header_widget.dart';
import 'package:food_delivery_app/views/categories/widgets/intro_text.dart';
import 'widgets/category_tile.dart';

class AllCategories extends HookWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchAllCategories();
    final categories = hookResult.data;
    final isLoading = hookResult.isLoading;

    return Scaffold(
      backgroundColor: kWhite,
      body: isLoading 
        ? const FoodsListShimmer() 
        : buildContent(categories),
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
