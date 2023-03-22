
class Customer {
  final String userId;
  final String phone;

  Customer({required this.userId, required this.phone});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      userId: json['userId'],
      phone: json['phone'],
    );
  }
}
