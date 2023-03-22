import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:waiter_app/models/food.dart';
import 'package:waiter_app/utils/config.dart';



class FoodProvider extends ChangeNotifier {
  final String _baseUrl = Config.URL_BASE;

  List<Food> popularFoods = [];
  List<Food> recommendFoods = [];

  Future<void> fetchFoods() async {
    final http.Response response;

    try {
      response = await http.get(Uri.parse("$_baseUrl/service/food"));
    } catch (e) {
      throw Exception('Failed to load foods' + e.toString());
    }

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      List<dynamic> popularFoodList = decodedData['popularFoods'];
      List<dynamic> recommendFoodList = decodedData['recommendFoods'];

      popularFoods = popularFoodList.map((food) => Food.fromJson(food)).toList();
      recommendFoods = recommendFoodList.map((food) => Food.fromJson(food)).toList();
    } else {
      throw Exception('Failed to load foods' + response.toString());
    }
  }
}
