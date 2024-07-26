import 'dart:convert';

PaymentRequestModel paymentRequestModelFromJson(String str) => PaymentRequestModel.fromJson(json.decode(str));

String paymentRequestModelToJson(PaymentRequestModel data) => json.encode(data.toJson());

class PaymentRequestModel {
    final String userId;
    final List<CartItem> cartItems;

    PaymentRequestModel({
        required this.userId,
        required this.cartItems,
    });

    factory PaymentRequestModel.fromJson(Map<String, dynamic> json) => PaymentRequestModel(
        userId: json["userId"],
        cartItems: List<CartItem>.from(json["cartItems"].map((x) => CartItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "cartItems": List<dynamic>.from(cartItems.map((x) => x.toJson())),
    };
}

class CartItem {
    final String name;
    final String id;
    final String price;
    final int quantity;
    final String restaurantId;

    CartItem({
        required this.name,
        required this.id,
        required this.price,
        required this.quantity,
        required this.restaurantId,
    });

    factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        name: json["name"],
        id: json["id"],
        price: json["price"],
        quantity: json["quantity"],
        restaurantId: json["restaurantId"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "price": price,
        "quantity": quantity,
        "restaurantId": restaurantId,
    };
}
