import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';

class FetchAddresses {
  final List<AddressResponseModel>? data;
  final bool isLoading;
  final Exception? error;
  final VoidCallback? refetch;

  FetchAddresses({
    required this.data,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
