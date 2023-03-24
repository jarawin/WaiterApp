// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';
import 'package:waiter_app/providers/cartProvider.dart';
import 'package:waiter_app/models/cart.dart';
import 'package:waiter_app/pages/cart/cart_item_list.dart';
import 'package:waiter_app/providers/customerProvider.dart';
import 'package:waiter_app/utils/colors.dart';
import 'package:waiter_app/utils/config.dart';
import 'package:waiter_app/utils/dimensions.dart';
import 'package:waiter_app/widgets/app_icon.dart';
import 'package:waiter_app/widgets/big_text.dart';
import 'package:waiter_app/providers/cartProvider.dart';
import 'package:waiter_app/widgets/small_text.dart';

class CartPage extends StatefulWidget {
  final String URL_BASE = Config.URL_BASE;

  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> _cartList = [];


  Widget _item_map() {
    if (_cartList.isNotEmpty) {
      return ListView.builder(
        itemCount: _cartList.length,
        itemBuilder: (context, index) {
          return CartItemList(
            index: index,
          );
        },
      );
    } else {
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "${widget.URL_BASE}/images/empty_cart.png",
                height: MediaQuery.of(context).size.height * 0.22,
              ),
              SmallText(text: "No items in cart.", size: Dimensions.font16,)
            ],
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<CartService>(builder: (_, cartService, __) {
      _cartList = cartService.getCart();

      Future<void> addOrderToServer() async {
        final response = await http.post(
          Uri.parse(widget.URL_BASE),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(_cartList),
        );

        if (response.statusCode == 200) {
          print('Data successfully posted');
          cartService.clearCart();
          print('Clear cart success');
        } else {
          print('Failed to post data: ${response.statusCode}');
        }
      }


      return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.height20 * 3,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        size: Dimensions.icon40,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Stack(
                          children: [
                            AppIcon(
                              icon: Icons.shopping_cart_outlined,
                              iconColor: Colors.white,
                              backgroundColor: AppColors.mainColor,
                              size: Dimensions.icon40,
                            ),
                            cartService.getTotalQuantity() >= 1
                                ? const Positioned(
                                    top: 0,
                                    right: 0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: Colors.white,
                                    ))
                                : Container(),
                            cartService.getTotalQuantity() >= 1
                                ? Positioned(
                                    top: 3,
                                    right: 3,
                                    child: Center(
                                        child: BigText(
                                            text: cartService
                                                .getTotalQuantity()
                                                .toInt()
                                                .toString(),
                                            size: 10,
                                            color: Colors.black)))
                                : Container(),
                          ],
                        )),
                  ],
                )),
            Positioned(
                top: Dimensions.height20 * 5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height15,
                  ),
                  child: MediaQuery.removePadding(
                      context: context, removeTop: true, child: _item_map()),
                ))
          ],
        ),
        bottomNavigationBar: Container(
            height: Dimensions.hPageView120,
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20)),
                    child: Row(
                      children: [
                        BigText(
                          text: "\฿ ${cartService.getTotalPrice()}",
                        ),
                      ],
                    )),
                GestureDetector(
                  onTap: () {
                    cartService.checksubPoint(cartService.getTotalPrice());//addOrderToServer();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height20),
                    child: BigText(
                      text: "Order by point",
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                        BorderRadius.circular(Dimensions.radius20)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    addOrderToServer();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height20),
                    child: BigText(
                      text: "Order now",
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20)),
                  ),
                )
              ],
            )),
      );
    });
  }
}
