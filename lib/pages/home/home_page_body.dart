// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:waiter_app/models/food.dart';
import 'package:waiter_app/providers/foodProvider.dart';
import 'package:waiter_app/utils/colors.dart';
import 'package:waiter_app/utils/config.dart';
import 'package:waiter_app/pages/home/food/popular_food_list.dart';
import 'package:waiter_app/pages/home/food/recommended_food_list.dart';

class HomePageBody extends StatefulWidget {
  final String URL_BASE = Config.URL_BASE;
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  FoodProvider foodProvider = FoodProvider();

  // Create variables to store fetched data
  List<Food> popularFoods = [];
  List<Food> recommendFoods = [];

  @override
  void initState() {
    super.initState();
    _fetchFoods();
  }

  // Fetch the data and store it in local variables
  Future<void> _fetchFoods() async {
    await foodProvider.fetchFoods();
    setState(() {
      popularFoods = foodProvider.popularFoods;
      recommendFoods = foodProvider.recommendFoods;
    });
  }


  @override
  Widget build(BuildContext context) {
    // Use a conditional rendering based on the length of popularFoods and recommendFoods
    if (popularFoods.isNotEmpty && recommendFoods.isNotEmpty) {
      return Column(
        children: [
          // slider section
          RecommendedFoodList(recommendFoods: recommendFoods),

          // popular text
          PopularFoodList(popularFoods: popularFoods),
        ],
      );
    } else {
      return const Center(
        child: Center(child: CircularProgressIndicator(color: AppColors.mainColor,)),
      );
    }
  }
}
