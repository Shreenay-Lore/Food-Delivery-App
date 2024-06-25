import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/additive_obs.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:get/get.dart';

class FoodController extends GetxController{

  ///Image Constants....
  final TextEditingController preferenceController = TextEditingController();

  RxInt currentPage = 0.obs;
  bool initialCheckValue = false;

  void changePage(int index){
    currentPage.value = index;
  }
  

  ///Quantity Constants...
  RxInt count = 1.obs;

  void increment() {
    count.value++;
  }

  void decrement() {
    if(count.value > 1){
      count.value--;
    }  
  }


  ///Additives Constants...
  var additivesList = <AdditiveObs>[].obs;

  void loadAdditives(List<Additive> additives){
    additivesList.clear();

    for (var additiveInfo in additives){
      var additive = AdditiveObs(
        id: additiveInfo.id,
        title: additiveInfo.title,
        price: additiveInfo.price,
        checked: initialCheckValue,
      );

      if(additives.length == additivesList.length){
      }else{
        additivesList.add(additive);
      }
    }
  }

  ///Functions to calculate total price after adding additives...
  RxDouble _totalPrice = 0.0.obs;

  double get additivePrice => _totalPrice.value;

  set setTotalPrice(double newPrice){
    _totalPrice.value = newPrice;
  }

  double getTotalPrice(){
    double totalPrice = 0.0;

    for (var additive in additivesList) {
      if (additive.isChecked.value) {
        totalPrice += double.tryParse(additive.price) ?? 0.0;
      }
    }

    setTotalPrice = totalPrice;
    return totalPrice;
  }  


}