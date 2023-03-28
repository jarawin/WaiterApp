// order.dart
import 'package:waiter_app/models/cart.dart';

class Order {
  final String id;
  final String userId;
  final List<Cart> items;
  final String orderId;
  final String status;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.orderId,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      userId: json['userId'],
      items: List<Cart>.from(
          json['orders'].map((item) => Cart.fromJson(item)).toList()),
      orderId: json['orderId'],
      status: json?['status'] ?? 'pending',
    );
  }

  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var cart in items) {
      totalPrice += cart.getSumPrice();
    }
    return totalPrice;
  }
}
