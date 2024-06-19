import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/custom_container.dart';
import 'package:food_delivery_app/common/custom_text_field.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/search_controller.dart';
import 'package:food_delivery_app/views/search/loading_widget.dart';
import 'package:food_delivery_app/views/search/search_results.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchFoodController());   

    return Obx(() => Scaffold(
        backgroundColor: kPrimary,
        appBar: AppBar(
          toolbarHeight: 74.h,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: CustomTextField(
              controller: controller.searchController,
              keyboardType: TextInputType.text,
              hintText: "Search For Foods",
              suffixIcon: GestureDetector(
                onTap: (){
                  if(controller.isTriggered == false){
                    controller.searchFoods(controller.searchController.text);
                    controller.setTrigger = true;
                  }else{
                    controller.searchResults = null;
                    controller.setTrigger = false;
                    controller.searchController.clear();
                  }
                  // Close the keyboard
                  FocusScope.of(context).unfocus();
                  
                },
                child: controller.isTriggered == false
                  ? Icon(Ionicons.search_circle, color: kPrimary, size: 34.h,)
                  : const Icon(Ionicons.close, color: kGray,)
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: CustomContainer(
            color: Colors.white,
            containerContent: controller.isLoading
                ? const FoodsListShimmer()
                : controller.searchResults == null 
                ? const LoadingWidget()
                : const SearchResults()
          ),
        ),
      ),
    );
    
  }
}