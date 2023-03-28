import 'package:waiter_app/models/food.dart';

class Cart {
  final Food food;
  late final int quantity;

  Cart({
    required this.food,
    required this.quantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      food: Food.fromJson(json['food']),
      quantity: json['quantity'],
    );
  }

  // Add this method to convert the Cart object to a JSON-encodable Map
  Map<String, dynamic> toJson() {
    return {
      'food': food.toJson(),
      'quantity': quantity,
    };
  }


  getSumPrice() {
    return quantity * food.price;
  }

  getSumQuantity(){
    return quantity;
  }
}
