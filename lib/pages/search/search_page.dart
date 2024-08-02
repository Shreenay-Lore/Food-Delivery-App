import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/custom_text_field.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/search/controller/search_controller.dart';
import 'package:food_delivery_app/pages/search/widget/loading_widget.dart';
import 'package:food_delivery_app/pages/search/widget/search_results.dart';
import 'package:get/get.dart';

class SearchPage extends GetView<SearchFoodController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          toolbarHeight: 74.h,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: kWhite,
          surfaceTintColor: kWhite,
          title: searchBar(context),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: controller.isLoading
                ? const FoodsListShimmer()
                : controller.searchResults == null 
                ? const LoadingWidget()
                : const SearchResults()
          ),
        ),
      ),
    );
  }

  Widget searchBar(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: CustomTextField(
        controller: controller.searchController,
        keyboardType: TextInputType.text,
        hintText: "Search For Foods",
        fillColor: kOffWhite,
        borderColor: Colors.transparent,
        prefixIcon: IconButton(
          onPressed: () {
            Get.back();
          }, 
          icon: Icon(Icons.arrow_back_ios_rounded, color: kGray, size: 18.h,)
        ),
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
            ? Icon(Ionicons.search_circle, color: kDark, size: 34.h,)
            : const Icon(Ionicons.close, color: kGray,)
        ),
      ),
    );
  }
  
}