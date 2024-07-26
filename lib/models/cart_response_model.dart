import 'dart:convert';

List<CartResponseModel> cartResponseModelFromJson(String str) => List<CartResponseModel>.from(json.decode(str).map((x) => CartResponseModel.fromJson(x)));

String cartResponseModelToJson(List<CartResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartResponseModel {
    final String id;
    final ProductId productId;
    final List<String> additives;
    final double totalPrice;
    final int quantity;

    CartResponseModel({
        required this.id,
        required this.productId,
        required this.additives,
        required this.totalPrice,
        required this.quantity,
    });

    factory CartResponseModel.fromJson(Map<String, dynamic> json) => CartResponseModel(
        id: json["_id"],
        productId: ProductId.fromJson(json["productId"]),
        additives: List<String>.from(json["additives"].map((x) => x)),
        totalPrice: json["totalPrice"]?.toDouble(),
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "productId": productId.toJson(),
        "additives": List<dynamic>.from(additives.map((x) => x)),
        "totalPrice": totalPrice,
        "quantity": quantity,
    };
}

class ProductId {
    final String id;
    final String title;
    final String restaurant;
    final double rating;
    final String ratingCount;
    final List<String> imageUrl;

    ProductId({
        required this.id,
        required this.title,
        required this.restaurant,
        required this.rating,
        required this.ratingCount,
        required this.imageUrl,
    });

    factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["_id"],
        title: json["title"],
        restaurant: json["restaurant"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "restaurant": restaurant,
        "rating": rating,
        "ratingCount": ratingCount,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
    };
}
