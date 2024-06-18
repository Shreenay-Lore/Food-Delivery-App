import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/shimmers/nearby_shimmer.dart';
import 'package:food_delivery_app/constants/uidata.dart';
import 'package:food_delivery_app/views/home/widgets/restaurant_widget.dart';

class NearbyRestaurants extends HookWidget {
  const NearbyRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    //final hookResult = useFetchRestaurants('41007428');
    //List<RestaurantsModel>? restaurants = hookResult.data;
    //final isLoading = hookResult.isLoading;
    //final error = hookResult.error;
    final isLoading = useState(true);  

    useEffect(() {
      // Simulate a delay for loading data
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false;
      });
      return;
    }, []);

    return isLoading.value
    ? const NearbyShimmer()
    : Container(
      height: 190.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child:  ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          restaurants.length,
          (index){
            var restaurant = restaurants[index];
            return  RestaurantWidget(
              image: restaurant['imageUrl'],
              logo: restaurant['logoUrl'],
              title: restaurant['title'],
              time: restaurant['time'],
              rating: restaurant['ratingCount'],
            );
          }
        ),
      ),
    );
  }
}

