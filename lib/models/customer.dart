
class Customer {
  final String userId;
  final String phone;
  //final int point;
  Customer({required this.userId, required this.phone,});//required this.point});

  factory Customer.fromJson(Map<String, dynamic> json)gi {
    return Customer(
      userId: json['userId'],
      phone: json['phone'],
     // point: json['point'],
    );
  }
}
