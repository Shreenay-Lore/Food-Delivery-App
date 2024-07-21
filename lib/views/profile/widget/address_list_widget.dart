import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/views/profile/widget/address_tile.dart';

class AddressListWidget extends StatelessWidget {
  const AddressListWidget({super.key, required this.addresses});

  final List<AddressResponseModel>? addresses;

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: addresses!.length,
      itemBuilder: (context, index) {
        final address = addresses![index];
        return Container(
          decoration: const BoxDecoration(
            color: kWhite,
            border: Border(
              bottom: BorderSide(
                color: kGray,
                width: 0.5,
              ),
            ),
          ),
          child: AddressTile(address: address),
        );
      },
    );
  }
}
