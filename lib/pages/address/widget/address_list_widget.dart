import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/pages/address/controllers/user_location_controller.dart';
import 'package:food_delivery_app/pages/address/widget/address_tile.dart';

class AddressListWidget extends StatelessWidget {
  const AddressListWidget({super.key, required this.addresses, required this.locationController});

  final List<AddressResponseModel>? addresses;
  final UserLocationController? locationController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 16.h),
      itemCount: addresses!.length,
      itemBuilder: (context, index) {
        final address = addresses![index];
        return AddressTile(
          address: address,
          locationController: locationController!,
        );
      },
    );
  }
}
