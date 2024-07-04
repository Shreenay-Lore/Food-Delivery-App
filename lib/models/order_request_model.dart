import 'dart:convert';

OrderRequestModel orderRequestModelFromJson(String str) => OrderRequestModel.fromJson(json.decode(str));

String orderRequestModelToJson(OrderRequestModel data) => json.encode(data.toJson());

class OrderRequestModel {
    final String userId;
    final List<OrderItem> orderItems;
    final double orderTotal;
    final int deliveryFee;
    final double grandTotal;
    final String deliveryAddress;
    final String restaurantAddress;
    final String paymentMethod;
    final String paymentStatus;
    final String orderStatus;
    final String restaurantId;
    final List<double> restaurantCoords;
    final List<double> recipientCoords;
    final String driverId;
    final int rating;
    final String feedback;
    final String promoCode;
    final double discountAmount;
    final String notes;

    OrderRequestModel({
        required this.userId,
        required this.orderItems,
        required this.orderTotal,
        required this.deliveryFee,
        required this.grandTotal,
        required this.deliveryAddress,
        required this.restaurantAddress,
        required this.paymentMethod,
        required this.paymentStatus,
        required this.orderStatus,
        required this.restaurantId,
        required this.restaurantCoords,
        required this.recipientCoords,
        required this.driverId,
        required this.rating,
        required this.feedback,
        required this.promoCode,
        required this.discountAmount,
        required this.notes,
    });

    factory OrderRequestModel.fromJson(Map<String, dynamic> json) => OrderRequestModel(
        userId: json["userId"],
        orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
        orderTotal: json["orderTotal"],
        deliveryFee: json["deliveryFee"],
        grandTotal: json["grandTotal"],
        deliveryAddress: json["deliveryAddress"],
        restaurantAddress: json["restaurantAddress"],
        paymentMethod: json["paymentMethod"],
        paymentStatus: json["paymentStatus"],
        orderStatus: json["orderStatus"],
        restaurantId: json["restaurantId"],
        restaurantCoords: List<double>.from(json["restaurantCoords"].map((x) => x?.toDouble())),
        recipientCoords: List<double>.from(json["recipientCoords"].map((x) => x?.toDouble())),
        driverId: json["driverId"],
        rating: json["rating"],
        feedback: json["feedback"],
        promoCode: json["promoCode"],
        discountAmount: json["discountAmount"],
        notes: json["notes"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "orderTotal": orderTotal,
        "deliveryFee": deliveryFee,
        "grandTotal": grandTotal,
        "deliveryAddress": deliveryAddress,
        "restaurantAddress": restaurantAddress,
        "paymentMethod": paymentMethod,
        "paymentStatus": paymentStatus,
        "orderStatus": orderStatus,
        "restaurantId": restaurantId,
        "restaurantCoords": List<dynamic>.from(restaurantCoords.map((x) => x)),
        "recipientCoords": List<dynamic>.from(recipientCoords.map((x) => x)),
        "driverId": driverId,
        "rating": rating,
        "feedback": feedback,
        "promoCode": promoCode,
        "discountAmount": discountAmount,
        "notes": notes,
    };
}

class OrderItem {
    final String foodId;
    final int quantity;
    final double price;
    final List<String> additives;
    final String instructions;

    OrderItem({
        required this.foodId,
        required this.quantity,
        required this.price,
        required this.additives,
        required this.instructions,
    });

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        foodId: json["foodId"],
        quantity: json["quantity"],
        price: json["price"],
        additives: List<String>.from(json["additives"].map((x) => x)),
        instructions: json["instructions"],
    );

    Map<String, dynamic> toJson() => {
        "foodId": foodId,
        "quantity": quantity,
        "price": price,
        "additives": List<dynamic>.from(additives.map((x) => x)),
        "instructions": instructions,
    };
}
