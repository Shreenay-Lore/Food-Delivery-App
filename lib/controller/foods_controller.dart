import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodController extends GetxController{
  final TextEditingController preferenceController = TextEditingController();
  
  RxInt currentPage = 0.obs;

  void changePage(int index){
    currentPage.value = index;
  }

  RxInt count = 1.obs;

  void increment() {
    count.value++;
  }

  void decrement() {
    if(count.value > 1){
      count.value--;
    }  
  }
}