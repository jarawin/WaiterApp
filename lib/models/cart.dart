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
      food: json['food'],
      quantity: json['quantity'],
    );
  }

  getSumPrice() {
    return quantity * food.price;
  }

  getSumQuantity(){
    return quantity;
  }
}
