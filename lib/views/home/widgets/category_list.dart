import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/shimmers/categories_shimmer.dart';
import 'package:food_delivery_app/constants/uidata.dart';

import 'category_widget.dart';

class CategoryList extends HookWidget {
    const CategoryList({super.key});
 
  @override
  Widget build(BuildContext context) {
    //final hookResult = useFetchCategories();
    // List<CategoriesModel>? categoriesList = hookResult.data;
    //final isLoading = hookResult.isLoading;
    // final error = hookResult.error;
    final isLoading = useState(true);  

    useEffect(() {
      // Simulate a delay for loading data
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false;
      });
      return;
    }, []);
   
    return isLoading.value
      ? const CatergoriesShimmer() 
      : Container(
      //color: Colors.black12,
      height: 80.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          categories.length,
          (index){
            var category = categories[index];
            return CategoryWidget(category: category);
          }
        ),
      ),
    );
  }
}
