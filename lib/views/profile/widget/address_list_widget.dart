import 'package:flutter/material.dart';
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
        return AddressTile(address: address);
      },
    );
  }
}
