import 'dart:convert';

CartCountResponseModel cartCountResponseModelFromJson(String str) => CartCountResponseModel.fromJson(json.decode(str));

String cartCountResponseModelToJson(CartCountResponseModel data) => json.encode(data.toJson());

class CartCountResponseModel {
    final bool status;
    final int count;

    CartCountResponseModel({
        required this.status,
        required this.count,
    });

    factory CartCountResponseModel.fromJson(Map<String, dynamic> json) => CartCountResponseModel(
        status: json["status"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
    };
}
