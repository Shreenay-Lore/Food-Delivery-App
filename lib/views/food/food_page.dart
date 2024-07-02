import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/custom_text_field.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/foods_controller.dart';
import 'package:food_delivery_app/controller/login_controller.dart';
import 'package:food_delivery_app/hooks/fetch_restaurant.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/models/login_response.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';
import 'package:food_delivery_app/views/auth/login_page.dart';
import 'package:food_delivery_app/views/auth/phone_verification_page.dart';
import 'package:food_delivery_app/views/restaurant/restaurant_page.dart';
import 'package:get/get.dart';

class FoodPage extends StatefulHookWidget {
  const FoodPage({super.key, required this.food,});

  final FoodsModel food;

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchRestaurant(widget.food.restaurant);
    RestaurantsModel? restaurant = hookResult.data;
    
    final FoodController controller = Get.put(FoodController());
    controller.loadAdditives(widget.food.additives);

    LoginResponse? user;
    final LoginController loginController = Get.put(LoginController());
    user = loginController.getUserInfo();

    return Scaffold(
      backgroundColor: kWhite,
      body: ListView(
        //physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30.r)),
              child: Stack(
                children: [
                  SizedBox(
                    height: 230.h,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        controller.changePage(index);
                      },
                      itemCount: widget.food.imageUrl.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: width,
                          height: 230.h,
                          color: kLightWhite,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.food.imageUrl[index],
          
                          ),
                        );
                      },
                    ),
                  ),
                  
                  ///Page Indicator....
                  Positioned(
                    bottom: 10.h,
                    left: 12.w,
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.food.imageUrl.length, 
                          (index){
                            return Container(
                              margin: EdgeInsets.all(4.h),
                              width: 10.w,
                              height: 10.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.currentPage == index
                                ? kSecondary
                                : kWhite
                              ),              
                            );
                          },
                        ),
                      ),
                    ),
                  ),
          
                  ///Back Button....
                  Positioned(
                    top: 40.h,
                    left: 12.w,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Ionicons.chevron_back_circle,
                        color: kWhite,
                        size: 30,
                      ),
                    )
                  ),
          
                  ///Restaurant Open/Close Status....
                  Positioned(
                    bottom: 10.h,
                    right: 12.w,
                    child: CustomButton(
                      onTap:() {
                        Get.to(()=> RestaurantPage(restaurant: restaurant,));
                      },
                      fontSize: 12,
                      text: "Open Restaurant",
                      width: 132.w,
                    ),
                  ),
          
                ],
              ),
          ),
          
          ///Food Title, Price, FoodTags.....
          Padding(
            padding: EdgeInsets.only(top: 10.h, left: 12.w, right: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Food Title & Price.....
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: widget.food.title, 
                      style: appStyle(18, kDark, FontWeight.w600)
                    ),
                    Obx(
                      ()=> CustomText(
                        text: "₹ ${((widget.food.price + controller.additivePrice) * controller.count.value)}", 
                        style: appStyle(18, kPrimary, FontWeight.w600)
                      ),
                    ),
                  ],
                ),
            
                SizedBox(height: 5.h,),
                
                Text(
                  widget.food.description,
                  textAlign: TextAlign.justify, 
                  maxLines: 8,
                  style: appStyle(10, kGray, FontWeight.w400)
                ),
            
                SizedBox(height: 5.h,),
                
                ///Food Tags.....
                SizedBox(
                  height: 18.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      widget.food.foodTags.length, 
                      (index) {
                        final tag = widget.food.foodTags[index];
                        return Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 5.w),
                          decoration: BoxDecoration(
                            color: kPrimary,
                            borderRadius: BorderRadius.all(Radius.circular(15.r))
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w,),
                            child: CustomText(
                              text: tag, 
                              style: appStyle(11, kWhite, FontWeight.w400)
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              
                SizedBox(height: 15.h,),
            
                CustomText(
                  text: "Additives & Toppings", 
                  style: appStyle(18, kDark, FontWeight.w600)
                ),
            
                SizedBox(height: 10.h,),
            
                ///Additives & Toppings
                Obx(
                  () => Column(
                    children: List.generate(
                      controller.additivesList.length, 
                      (index) { 
                        final additive = controller.additivesList[index];
                        return CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          value: additive.isChecked.value, 
                          activeColor: kPrimary,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: additive.title, 
                                style: appStyle(11, kDark, FontWeight.w400)
                              ),
                              CustomText(
                                text: "₹ ${additive.price}", 
                                style: appStyle(11, kPrimary, FontWeight.w600)
                              ),
                            ],
                          ),
                          onChanged: (bool? value) {
                            additive.toggleChecked();
                            controller.getTotalPrice();
                          },
                        );
                      }
                    ),
                  ),
                ),
                
                SizedBox(height: 20.h,),
            
                CustomText(
                  text: "Preferences", 
                  style: appStyle(18, kDark, FontWeight.w600)
                ),
                SizedBox(height: 5.h,),
                SizedBox(
                  height: 55.h,
                  child: CustomTextField(
                    maxLines: 3,
                    controller: controller.preferenceController,
                    keyboardType: TextInputType.text,
                    hintText: "Add a note",
                  ),
                ),
            
                SizedBox(height: 20.h,),
            
                ///Quantity...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Quantity", 
                      style: appStyle(18, kDark, FontWeight.w600)
                    ),
            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            controller.increment();
                          },
                          child: const Icon(AntDesign.plussquareo, color: kPrimary,)
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Obx(
                            ()=> CustomText(
                              text: "${controller.count.value}", 
                              style: appStyle(14, kDark, FontWeight.w600)
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            controller.decrement();
                          },
                          child: const Icon(AntDesign.minussquareo, color: kPrimary,)
                        ),
                      ],
                    ),
            
                  ],
                ),

                SizedBox(height: 20.h,),

                ///Place Order & Add to Cart Button....
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(20.r)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      GestureDetector(
                        onTap: (){
                          if(user == null){
                            Get.to(()=> const LoginPage());
                          }
                          else if(user.phoneVerification == false){
                            showVerificationSheet();
                          }
                          else{
                            Get.snackbar("Place Order", '');
                          }
                          
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: CustomText(
                            text: "Place Order", 
                            style: appStyle(18, kLightWhite, FontWeight.w600)
                          ),
                        ),
                      ),

                      GestureDetector(
                        child: CircleAvatar(
                          radius: 18.r,
                          backgroundColor: kSecondary,
                          child: const Icon(
                            Ionicons.cart,
                            color: kLightWhite,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
            
              ],
            ),
          ),


        ],
      ),
    );
  }

  Future<dynamic> showVerificationSheet(){
    return showModalBottomSheet(
      context: context,
      showDragHandle: true, 
      //backgroundColor: Colors.transparent,
      builder: (context) {
        return SizedBox(
          height: 500.h,
          width: width,
          child: Padding(
            padding: EdgeInsets.all(8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h,),
                CustomText(
                  text: "Verify Your Phone Number", 
                  style: appStyle(18, kPrimary, FontWeight.w600)
                ),
                SizedBox(height: 10.h,),
                SizedBox(
                  height: 250.h,
                  child: Column(
                    children: List.generate(
                      verificationReasons.length, 
                      (index) => ListTile(
                        leading: const Icon(Icons.check, color: kPrimary,),
                        title: Text(
                          verificationReasons[index],
                          textAlign: TextAlign.justify,
                          style: appStyle(11, kGrayLight, FontWeight.normal)
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomButton(  
                    height: 40.h,
                    width: width,
                    backgroundColor: kPrimary,
                    borderColor: kPrimary,
                    textColor: kWhite,
                    text: 'Verify Phone Number',
                    onTap: () {
                      Get.to(()=> const PhoneVerificationPage());
                    },
                  ),
                ),
                SizedBox(height: 5.h,),
              ],
            ),
          ),
        );
      },
    );
  }

}