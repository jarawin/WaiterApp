import 'package:flutter/foundation.dart';

class Food {
  final String id;
  final String name;
  final String image;
  final String description;
  final String category;
  final int price;
  final int rating;

  Food({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
      rating: json['rate'],
      category: json['category'],
    );
  }
}
