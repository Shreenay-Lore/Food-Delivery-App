import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/address_bottom_sheet.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/custom_text_field.dart';
import 'package:food_delivery_app/common/phone_verification_bottom_sheet.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/foods_controller.dart';
import 'package:food_delivery_app/controller/login_controller.dart';
import 'package:food_delivery_app/hooks/fetch_default_address.dart';
import 'package:food_delivery_app/hooks/fetch_restaurant.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/models/login_response.dart';
import 'package:food_delivery_app/models/order_request_model.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';
import 'package:food_delivery_app/views/auth/login_page.dart';
import 'package:food_delivery_app/views/food/widgets/food_bottom_nav_bar.dart';
import 'package:food_delivery_app/views/orders/order_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FoodPageBottomSheet extends StatelessWidget {
  final FoodsModel food;

  const FoodPageBottomSheet({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return BottomSheetContent(food: food);
  }
}

class BottomSheetContent extends StatefulHookWidget {
  const BottomSheetContent({super.key, required this.food});

  final FoodsModel food;

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  final _pageController = PageController();
  late final FoodController foodController;
  late final LoginController loginController;

  @override
  void initState() {
    super.initState();
    foodController = Get.put(FoodController(), permanent: false);
    loginController = Get.put(LoginController(), permanent: false);
    foodController.loadAdditives(widget.food.additives);
  }

  @override
  void dispose() {
    Get.delete<FoodController>();
    Get.delete<LoginController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage(); 
    var addressTrigger = box.read("defaultAddress");
    LoginResponse? user;

    final hookResult = useFetchRestaurant(widget.food.restaurant);
    RestaurantsModel? restaurant = hookResult.data;
    
    final data = useFetchDefaultAddress(context);
    AddressResponseModel? address = data.data;

    user = loginController.getUserInfo();

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
      child: DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.8,
        minChildSize: 0.6,
        initialChildSize: 0.8,
        builder: (context, scrollController) {
          return ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.72,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r), 
                            topRight: Radius.circular(20.r), 
                            bottomRight: Radius.circular(0.r)),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 280.h,
                                  child: PageView.builder(
                                    controller: _pageController,
                                    onPageChanged: (index) {
                                      foodController.changePage(index);
                                    },
                                    itemCount: widget.food.imageUrl.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 260.h,
                                        color: kLightWhite,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: widget.food.imageUrl[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 10.h,
                                  left: 12.w,
                                  child: Obx(
                                    () => Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(
                                        widget.food.imageUrl.length, 
                                        (index) {
                                          return Container(
                                            margin: EdgeInsets.all(4.h),
                                            width: 10.w,
                                            height: 10.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: foodController.currentPage == index
                                              ? kWhite
                                              : kDark
                                            ),              
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, left: 12.w, right: 12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: widget.food.title, 
                                style: appStyle(16, kDark, FontWeight.w600)
                              ),
                              SizedBox(height: 5.h,),
                              Text(
                                widget.food.description,
                                textAlign: TextAlign.justify, 
                                maxLines: 8,
                                style: appStyle(10, kGray, FontWeight.w400)
                              ),
                              SizedBox(height: 10.h,),
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
                                          color: kOffWhite,
                                          borderRadius: BorderRadius.all(Radius.circular(4.r))
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.w,),
                                          child: CustomText(
                                            text: tag, 
                                            style: appStyle(10, kDark, FontWeight.w600)
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              const Divider(thickness: 0.5),
                              SizedBox(height: 10.h,),
                              CustomText(
                                text: "Choose your Additives & Toppings", 
                                style: appStyle(14, kDark, FontWeight.w600)
                              ),
                              SizedBox(height: 10.h,),
                              Obx(
                                () => Column(
                                  children: List.generate(
                                    foodController.additivesList.length, 
                                    (index) { 
                                      final additive = foodController.additivesList[index];
                                      return CheckboxListTile(
                                        contentPadding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                        dense: true,
                                        value: additive.isChecked.value, 
                                        activeColor: kDark,
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: additive.title, 
                                              style: appStyle(11, kDark, FontWeight.w400)
                                            ),
                                            CustomText(
                                              text: "₹ ${additive.price}", 
                                              style: appStyle(11, kDark, FontWeight.w600)
                                            ),
                                          ],
                                        ),
                                        onChanged: (bool? value) {
                                          additive.toggleChecked();
                                          foodController.getTotalPrice();
                                          foodController.getCartAdditive();
                                        },
                                      );
                                    }
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h,),
                              const Divider(thickness: 0.5),
                              SizedBox(height: 10.h,),
                              CustomText(
                                text: "Preferences", 
                                style: appStyle(14, kDark, FontWeight.w600)
                              ),
                              SizedBox(height: 5.h,),
                              SizedBox(
                                height: 55.h,
                                child: CustomTextField(
                                  maxLines: 3,
                                  controller: foodController.preferenceController,
                                  keyboardType: TextInputType.text,
                                  hintText: "Add a note with your preferences",
                                ),
                              ),              
                              SizedBox(height: 20.h,),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 40,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: kGray,
                                    borderRadius: BorderRadius.circular(8.r)
                                  ),
                                  child: GestureDetector(
                                    onTap: (){
                                      if(user == null){
                                        Get.to(()=> const LoginPage());
                                      }
                                      else if(user.phoneVerification == false){
                                        showVerificationSheet(context);
                                      }
                                      else if(addressTrigger == false){
                                        showAddressSheet(context);
                                      }
                                      else{
                                        double totalPrice = (widget.food.price + foodController.additivePrice) * foodController.count.value;
                                        OrderItem item = OrderItem(
                                          foodId: widget.food.id,
                                          quantity: foodController.count.value,
                                          price: totalPrice,
                                          additives: foodController.getCartAdditive(),
                                          instructions: foodController.preferenceController.text,
                                        );
                                        Get.to(
                                          ()=> OrderPage(
                                            item: item,
                                            restaurant: restaurant,
                                            food: widget.food,
                                            address: address,
                                          ),
                                          transition: Transition.cupertino,
                                          duration: const Duration(milliseconds: 900)
                                        );
                                      }
                                    },
                                    child: Center(
                                      child: CustomText(
                                        text: "Place Order", 
                                        style: appStyle(14, kLightWhite, FontWeight.w600)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 40.h,),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FoodPageBottomNavBar(food: widget.food,),
            ],
          );
        },
      ),
    );
  }
}
