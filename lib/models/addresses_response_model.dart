import 'dart:convert';

List<AddressResponseModel> addressResponseModelFromJson(String str) => List<AddressResponseModel>.from(json.decode(str).map((x) => AddressResponseModel.fromJson(x)));

String addressResponseModelToJson(List<AddressResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressResponseModel {
    final String? id;
    final String? userId;
    final String? addressLine1;
    final String? postalCode;
    final bool? addressResponseModelDefault;
    final String? deliveryInstructions;
    final double? latitude;
    final double? longitude;
    final int? v;

    AddressResponseModel({
        this.id,
        this.userId,
        this.addressLine1,
        this.postalCode,
        this.addressResponseModelDefault,
        this.deliveryInstructions,
        this.latitude,
        this.longitude,
        this.v,
    });

    factory AddressResponseModel.fromJson(Map<String, dynamic> json) => AddressResponseModel(
        id: json["_id"],
        userId: json["userId"],
        addressLine1: json["addressLine1"],
        postalCode: json["postalCode"],
        addressResponseModelDefault: json["default"],
        deliveryInstructions: json["deliveryInstructions"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "addressLine1": addressLine1,
        "postalCode": postalCode,
        "default": addressResponseModelDefault,
        "deliveryInstructions": deliveryInstructions,
        "latitude": latitude,
        "longitude": longitude,
        "__v": v,
    };
}
