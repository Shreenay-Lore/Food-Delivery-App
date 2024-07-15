import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/custom_container.dart';
import 'package:food_delivery_app/common/custom_text_field.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/search_controller.dart';
import 'package:food_delivery_app/views/search/widget/loading_widget.dart';
import 'package:food_delivery_app/views/search/search_results.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchFoodController());   

    // // Focus the text field after the first frame is rendered
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   FocusScope.of(context).requestFocus(_focusNode);
    // });
    

    return Obx(() => Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          toolbarHeight: 74.h,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: kWhite,
          title: Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: CustomTextField(
              controller: controller.searchController,
              focusNode: _focusNode,
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
          ),
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
}