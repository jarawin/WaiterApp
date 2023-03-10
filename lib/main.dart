import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/provider/cartProvider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
        create: (context) => CartService(),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: const CartPage()));

          home: const MainFoodPage(),
        ));
    // home: const PopularFoodDetail());
  }
}
